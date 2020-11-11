import C_nnc

public protocol DynamicGraph_AnyTensorGroup {
  associatedtype AnyTensor
  static func exec(cmd: ccv_nnc_cmd_t, hint: ccv_nnc_hint_t, inputs: [AnyTensor], outputSize: Int32, streamContext: StreamContext?) -> [AnyTensor]
  static func evaluate(model: Model, inputs: [AnyTensor], streamContext: StreamContext?) -> [AnyTensor]
}

public extension DynamicGraph {
  typealias AnyTensorGroup = DynamicGraph_AnyTensorGroup
}

extension DynamicGraph.AnyTensor: DynamicGraph.AnyTensorGroup {
  public typealias AnyTensor = DynamicGraph.AnyTensor
  public static func exec(cmd: ccv_nnc_cmd_t, hint: ccv_nnc_hint_t, inputs: [AnyTensor], outputSize: Int32, streamContext: StreamContext?) -> [AnyTensor] {
    assert(inputs.count > 0)
    let graph = inputs[0].graph
    for input in inputs {
      assert(input.graph === graph)
    }
    let _inputs: [ccv_nnc_tensor_variable_t?] = inputs.map { $0._tensor }
    let _outputs = UnsafeMutablePointer<ccv_nnc_tensor_variable_t?>.allocate(capacity: Int(outputSize))
    let outputs: [DynamicGraph.AnyTensor] = (0..<outputSize).map { _ in graph.variable() }
    for (i, variable) in outputs.enumerated() {
      (_outputs + i).initialize(to: variable._tensor)
    }
    let _graph = graph._graph
    let _streamContext = streamContext?._stream
    ccv_nnc_dynamic_graph_exec(_graph, cmd, hint, 0, _inputs, Int32(_inputs.count), _outputs, outputSize, 0, _streamContext)
    _outputs.deallocate()
    return outputs
  }
  public static func evaluate(model: Model, inputs: [AnyTensor], streamContext: StreamContext?) -> [AnyTensor] {
    assert(inputs.count > 0)
    let graph = inputs[0].graph
    for input in inputs {
      assert(input.graph === graph)
    }
    let _inputs: [ccv_nnc_tensor_variable_t?] = inputs.map { $0._tensor }
    let _model = model._model
    let outputSize = ccv_cnnp_model_output_size(_model)
    let _outputs = UnsafeMutablePointer<ccv_nnc_tensor_variable_t?>.allocate(capacity: Int(outputSize))
    let outputs: [DynamicGraph.AnyTensor] = (0..<outputSize).map { _ in graph.variable() }
    for (i, variable) in outputs.enumerated() {
      (_outputs + i).initialize(to: variable._tensor)
    }
    let _graph = graph._graph
    let _streamContext = streamContext?._stream
    let isTest = model.isTest
    ccv_nnc_dynamic_graph_evaluate(_graph, _model, isTest ? 1 : 0, _inputs, Int32(_inputs.count), _outputs, outputSize, nil, _streamContext)
    _outputs.deallocate()
    return outputs
  }
}

extension Array: DynamicGraph.AnyTensorGroup where Element: DynamicGraph.AnyTensor {
  public typealias AnyTensor = [DynamicGraph.AnyTensor]
  public static func exec(cmd: ccv_nnc_cmd_t, hint: ccv_nnc_hint_t, inputs: [AnyTensor], outputSize: Int32, streamContext: StreamContext?) -> [AnyTensor] {
    return []
  }
  public static func evaluate(model: Model, inputs: [AnyTensor], streamContext: StreamContext?) -> [AnyTensor] {
    return []
  }
}

public protocol DynamicGraph_TensorGroup: DynamicGraph_AnyTensorGroup {
  associatedtype Element: TensorNumeric
  init(_: AnyTensor)
}

public extension DynamicGraph {
  typealias TensorGroup = DynamicGraph_TensorGroup
}

public protocol _DynamicGraph_TensorGroup {
  associatedtype _Element: TensorNumeric
  init(_: DynamicGraph.AnyTensor)
}

extension DynamicGraph.Tensor: _DynamicGraph_TensorGroup {
  public typealias _Element = Element
}

extension DynamicGraph.Tensor: DynamicGraph.TensorGroup {
  public typealias Element = Element
}

extension Array: DynamicGraph.TensorGroup where Element: _DynamicGraph_TensorGroup, Element: DynamicGraph.AnyTensor {
  public typealias Element = Element._Element
  public init(_ obj: AnyTensor) {
    self.init(obj.map { Element($0) })
  }
}

public enum Functional {
  internal static func exec<T: DynamicGraph.AnyTensorGroup>(_: T.Type, cmd: ccv_nnc_cmd_t, hint: ccv_nnc_hint_t, inputs: [T.AnyTensor], outputSize: Int32, streamContext: StreamContext? = nil) -> [T.AnyTensor] {
    return T.exec(cmd: cmd, hint: hint, inputs: inputs, outputSize: outputSize, streamContext: streamContext)
  }
  static func exec<T: DynamicGraph.AnyTensorGroup>(cmd: ccv_nnc_cmd_t, hint: ccv_nnc_hint_t, inputs: [T], outputSize: Int32, streamContext: StreamContext? = nil) -> [T.AnyTensor] {
    return exec(T.self, cmd: cmd, hint: hint, inputs: inputs as! [T.AnyTensor], outputSize: outputSize, streamContext: streamContext)
  }
}

public extension Model {
  internal func callAsFunction<T: DynamicGraph.AnyTensorGroup>(_: T.Type, _ inputs: [T.AnyTensor], streamContext: StreamContext? = nil) -> [T.AnyTensor] {
    return T.evaluate(model: self, inputs: inputs, streamContext: streamContext)
  }
  func callAsFunction<T: DynamicGraph.AnyTensorGroup>(_ inputs: [T], streamContext: StreamContext? = nil) -> [T.AnyTensor] {
    return self(T.self, inputs as! [T.AnyTensor], streamContext: streamContext)
  }
}
