import nnc
import Foundation

func SelfAttention(k: Int, h: Int, b: Int, t: Int, dropout: Float) -> Model
{
  let x = Input()
  let mask = Input()
  let multiheads = x.reshape([b * t, k])
  let tokeys = Dense(count: k * h, noBias: true)
  let toqueries = Dense(count: k * h, noBias: true)
  let tovalues = Dense(count: k * h, noBias: true)
  let keys = tokeys(multiheads).reshape([t, b, h, k]).transpose(0, 2).reshape([b * h, t, k])
  let queries = toqueries(multiheads).reshape([t, b, h, k]).transpose(0, 2).reshape([b * h, t, k])
  let values = tovalues(multiheads).reshape([t, b, h, k]).transpose(0, 2).reshape([b * h, t, k])
  var dot = Matmul(transposeB: (1, 2))(queries, keys)
  dot = (1.0 / Float(k).squareRoot()) * dot
  dot = MaskedFill(equalTo: 0, fillWith: 1e-9)(dot, mask)
  dot = dot.reshape([b * h * t, t])
  dot = Softmax()(dot)
  if dropout > 0 {
    dot = Dropout(probability: dropout)(dot)
  }
  dot = dot.reshape([b * h, t, t])
  var out = dot * values
  out = out.reshape([h, b, t, k]).transpose(0, 2).reshape([b * t, h * k])
  let unifyheads = Dense(count: k)
  out = unifyheads(out).reshape([t, b, k])
  return Model([x, mask], [out])
}

func TransformerBlock(k: Int, h: Int, b: Int, t: Int, ff: Int, dropout: Float) -> Model
{
  let x = Input()
  let mask = Input()
  let selfAttention = SelfAttention(k: k, h: h, b: b, t: t, dropout: dropout)
  var out = selfAttention(x, mask)
  out = x + out
  let first = LayerNorm(epsilon: 1e-5, axis: [2])(out)
  if dropout > 0 {
    out = Dropout(probability: dropout)(first)
  } else {
    out = first
  }
  out = out.reshape([b * t, k])
  out = Dense(count: ff)(out)
  out = RELU()(out)
  out = Dense(count: k)(out)
  out = out.reshape([t, b, k])
  out = first + out
  out = LayerNorm(epsilon: 1e-5, axis: [2])(out)
  if dropout > 0 {
    out = Dropout(probability: dropout)(out)
  }
  return Model([x, mask], [out])
}

func ClassicTransformer(layers: Int, k: Int, h: Int, b: Int, t: Int, ff: Int, dropout: Float) -> Model
{
  let x = Input()
  let mask = Input()
  var out = x.transpose(0, 1)
  for _ in 0..<layers {
    out = TransformerBlock(k: k, h: h, b: b, t: t, ff: ff, dropout: dropout)(out, mask)
  }
  out = out.transpose(0, 1).transpose(1, 2).reshape([b, k, t, 1])
  out = AveragePool()(out)
  out = Flatten()(out)
  out = Dense(count: 1)(out)
  return Model([x, mask], [out])
}

struct TransformerParameter {
  var ff: Int
  var layers: Int
  var h: Int
  var dropout: Float
}

let parameters = TransformerParameter(ff: 4, layers: 2, h: 8, dropout: 0.1)

let dynamicClassicTransformer: ModelBuilder = ModelBuilder { inputs in
  let b = inputs[0].dimensions[0]
  let t = inputs[0].dimensions[1]
  let k = inputs[0].dimensions[2]
  return ClassicTransformer(layers: parameters.layers, k: k, h: parameters.h, b: b, t: t, ff: parameters.ff * k, dropout: parameters.dropout)
}

let graph = DynamicGraph()

let trainListFile = "/fast/Data/IMDB_Movie_Reviews/aclImdb/train.txt"
let testListFile = "/fast/Data/IMDB_Movie_Reviews/aclImdb/test.txt"
let vocabFile = "/fast/Data/IMDB_Movie_Reviews/aclImdb/imdb.vocab"
let baseDir = "/fast/Data/IMDB_Movie_Reviews/aclImdb"

let vocabContent = try! String(contentsOfFile: vocabFile, encoding: .utf8)
let vocabList = vocabContent.split(separator: "\n")

var dict = [String: Int]()
for (i, word) in vocabList.enumerated() {
  let lowercasedWord = word.lowercased()
  dict[lowercasedWord] = i
}

let unknownFlag = Int32(vocabList.count)
let endFlag = Int32(vocabList.count + 1)
let padFlag = Int32(vocabList.count + 2)
let maxLength = 512

struct ImdbText {
  var tensor: Tensor<Int32>
  var mask: Tensor<Int32>
  var c: Int
}

func dataFromDisk(filePath trainListFile: String) -> DataFrame {
  let trainListContent = try! String(contentsOfFile: trainListFile, encoding: .utf8)
  let trainList = trainListContent.split(separator: "\n")
  var trainData = [ImdbText]()
  for trainFile in trainList {
    let parts = trainFile.split(separator: " ")
    let c = Int(parts[0])!
    let filePath = parts[1...].joined(separator: " ")
    let trainText = try! String(contentsOfFile: "\(baseDir)/\(filePath)", encoding: .utf8)
    let lowercasedTrainText = trainText.lowercased()
    let separators: Set<Character> = [" ", ".", ",", "<", ">", "/", "~", "`", "@", "#", "$", "%", "^", "&", "*", "+", "\\", "\""]
    let tokens = lowercasedTrainText.split(whereSeparator: { character in
      return separators.contains(character)
    })
    var tensor = Tensor<Int32>(.CPU, .C(maxLength))
    for (i, token) in tokens.enumerated() where i < maxLength {
      tensor[i] = dict[String(token)].map { Int32($0) } ?? unknownFlag
    }
    if tokens.count < maxLength {
      for i in tokens.count..<maxLength {
        tensor[i] = i == tokens.count ? endFlag : padFlag
      }
    }
    var mask = Tensor<Int32>(.CPU, .C(1))
    mask[0] = Int32(min(tokens.count + 1, maxLength))
    let imdbText = ImdbText(tensor: tensor, mask: mask, c: c)
    trainData.append(imdbText)
  }
  return DataFrame(from: trainData, name: "main")
}

let trainData = dataFromDisk(filePath: trainListFile)
let testData = dataFromDisk(filePath: testListFile)
trainData["tensor"] = trainData["main", ImdbText.self].map(\.tensor)
trainData["mask"] = trainData["main", ImdbText.self].map(\.mask)
trainData["oneHot"] = trainData["main", ImdbText.self].map { imdbText -> Tensor<Float> in
  let c = imdbText.c
  var tensor = Tensor<Float>(.CPU, .C(2))
  if c == 1 {
    tensor[0] = 0
    tensor[1] = 1
  } else {
    tensor[0] = 1
    tensor[1] = 0
  }
  return tensor
}
testData["tensor"] = testData["main", ImdbText.self].map(\.tensor)
testData["mask"] = testData["main", ImdbText.self].map(\.mask)
testData["oneHot"] = testData["main", ImdbText.self].map { imdbText -> Tensor<Float> in
  let c = imdbText.c
  var tensor = Tensor<Float>(.CPU, .C(2))
  if c == 1 {
    tensor[0] = 0
    tensor[1] = 1
  } else {
    tensor[0] = 1
    tensor[1] = 0
  }
  return tensor
}

