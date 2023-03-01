import C_nnc

/// A type-erased model builder.
public class AnyModelBuilder {

  public var isTest: Bool = false

  var model: Model? = nil
  var t: Any? = nil
  var inputs: [DynamicGraph_Any]? = nil
  private let builder: (_: Any, _: [DynamicGraph_Any]) -> Model

  fileprivate init(builder: @escaping (_: Any, _: [DynamicGraph_Any]) -> Model, name: String = "") {
    self.builder = builder
    let _model = ccv_cnnp_dynamic_new(
      { _, _, ctx in
        let modelBuilder = Unmanaged<AnyModelBuilder>.fromOpaque(ctx!).takeUnretainedValue()
        let t = modelBuilder.t!
        let inputs = modelBuilder.inputs!
        let builder = modelBuilder.builder
        let model = builder(t, inputs)
        return model.obtainUnderlyingModel(modelBuilder.model!)
      }, Unmanaged.passUnretained(self).toOpaque(), name)!
    model = Model(_model)
  }

  private var _outputSize: Int? = nil
  var outputSize: Int {
    if let outputSize = _outputSize {
      return outputSize
    }
    // Compile explicitly.
    compileModel()
    // After the model compiled, we can access the outputSize now.
    let outputSize = Int(ccv_cnnp_model_output_size(model!.cModel))
    _outputSize = outputSize
    return outputSize
  }

  /**
   * Abstract representation of the stateful components from the model builder.
   */
  public var parameters: Model.Parameters {
    model!.parameters
  }

  /**
   * Broadly speaking, you can have two types of parameters, weight and bias.
   * You can get them in abstract fashion with this method.
   *
   * - Parameter type: Whether it is weight or bias.
   * - Returns: An abstract representation of parameters.
   */
  public func parameters(for type: Model.ParametersType) -> Model.Parameters {
    return model!.parameters(for: type)
  }

  private var _store: DynamicGraph._Store? = nil
  private var _key: String? = nil

  func read(_ key: String, from store: DynamicGraph._Store) {
    // If the model is compiled (signifies by _outputSize is set)
    if _outputSize != nil {
      ccv_cnnp_model_read(store.sqlite, key, model!.cModel)
      return
    }
    _store = store
    _key = key
  }

  private func compileModel() {
    let inputs = self.inputs!
    model!.compile(inputs: inputs)
    // If we have store / key, try to load parameters now after it is compiled.
    if let store = _store, let key = _key {
      ccv_cnnp_model_read(store.sqlite, key, model!.cModel)
      _store = nil
      _key = nil
    }
  }

  /**
   * Compile a model with the given inputs without executing it. After this, you can load
   * parameters from the store.
   */
  public func compile(inputs: [DynamicGraph_Any]) {
    self.inputs = inputs
    compileModel()
    self.inputs = nil
  }

  /**
   * Compile a model with the given inputs without executing it. After this, you can load
   * parameters from the store.
   */
  public func compile(inputs: DynamicGraph_Any...) {
    compile(inputs: inputs)
  }

}

/// A model builder is a more generic type of model. A model can be quite static,
/// thus, you have to be quite careful to have a model work with dynamic inputs.
/// You cannot use reshape, or anything that can generate fixed tensor outputs from
/// a fixed inputs.
///
/// A model builder on the other hand doesn't have that restriction. When input changes,
/// it simply calls the given builder closure to construct a new model. In such way,
/// you can continue to use reshape etc to assume fixed inputs and outputs, it will just
/// work for dynamic inputs. The newly built model will carry over stateful components
/// (parameters) from the old models, thus, it doesn't reset your training. This also means
/// you need to make sure parameter shape won't change when input changes, otherwise we
/// will fatal.
public final class ModelBuilder<T>: AnyModelBuilder {
  public init(_ builder: @escaping (_: T, _: [DynamicGraph_Any]) -> Model, name: String = "") {
    super.init(
      builder: { t, inputs in
        return builder(t as! T, inputs)
      }, name: name)
  }
}

extension ModelBuilder where T == Void {
  public convenience init(_ builder: @escaping (_: [DynamicGraph_Any]) -> Model, name: String = "")
  {
    self.init(
      { t, inputs in
        return builder(inputs)
      }, name: name)
  }
}
