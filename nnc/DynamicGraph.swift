import C_nnc

public final class DynamicGraph {

  fileprivate class _AnyTensor {

    let graph: DynamicGraph
    let _tensor: ccv_nnc_tensor_variable_t

    init(graph: DynamicGraph, tensor: ccv_nnc_tensor_variable_t) {
      self.graph = graph
      _tensor = tensor
    }

    deinit {
      ccv_nnc_tensor_variable_free(graph._graph, _tensor)
    }
  }

  public class AnyTensor {

    internal(set) public var grad: AnyTensor? = nil

    fileprivate let underlying: _AnyTensor

    var graph: DynamicGraph { underlying.graph }
    var _tensor: ccv_nnc_tensor_variable_t { underlying._tensor }

    fileprivate init(graph: DynamicGraph, tensor: ccv_nnc_tensor_variable_t) {
      underlying = _AnyTensor(graph: graph, tensor: tensor)
    }

    fileprivate init(_ underlying: _AnyTensor) {
      self.underlying = underlying
    }
  }

  public final class Tensor<Element: TensorNumeric>: AnyTensor {
    private var _rawValue: nnc._AnyTensor? = nil

    public var rawValue: nnc.Tensor<Element> {
      let _graph = graph._graph
      let tensor = ccv_nnc_tensor_from_variable_impl(_graph, _tensor, nil)!
      let rawValue = nnc._AnyTensor(tensor, original: self) // To enforce copy-on-write syntax.
      _rawValue = rawValue
      return nnc.Tensor<Element>(rawValue)
    }

    // If we did type conversion, we need to hold a reference to its parent.
    public convenience init(_ tensor: AnyTensor) {
      self.init(tensor.underlying)
    }
  }

  let _graph: OpaquePointer

  public init() {
    ccv_nnc_init()
    _graph = ccv_nnc_dynamic_graph_new()
  }

  deinit {
    ccv_nnc_dynamic_graph_free(_graph)
  }
}

public func ==(lhs: DynamicGraph.AnyTensor, rhs: DynamicGraph.AnyTensor) -> Bool {
  return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}

extension DynamicGraph.AnyTensor: Hashable {
  public func hash(into hasher: inout Hasher) {
    ObjectIdentifier(self).hash(into: &hasher)
  }
}

public extension DynamicGraph.Tensor {

  func reshape(format: TensorFormat, dimensions: [Int], offset: [Int]? = nil, increments: [Int]? = nil) -> DynamicGraph.Tensor<Element> {
    let _graph = graph._graph
    let cTensorParams = ccv_nnc_tensor_variable_params(_graph, _tensor)
    let device = DeviceKind.from(cTensorParams: cTensorParams)
    var offset = toCDimensions(offset)
    var increments = toCDimensions(increments)
    let _alias = withUnsafePointer(to: &offset.0) { offset in
      withUnsafePointer(to: &increments.0) { increments in
        ccv_nnc_tensor_variable_alias_new(_graph, _tensor, offset, increments,
          toCTensorParams(device, dataType: Element.dataType, format: format, dimensions: dimensions))!
      }
    }
    return DynamicGraph.Tensor<Element>(graph: underlying.graph, tensor: _alias)
  }

  func reshape(_ dimensionFormat: TensorDimensionFormat, offset: [Int]? = nil, increments: [Int]? = nil) -> DynamicGraph.Tensor<Element> {
    switch dimensionFormat {
    case let .NHWC(n, h, w, c):
      return reshape(format: .NHWC, dimensions: [n, h, w, c], offset: offset, increments: increments)
    case let .NCHW(n, c, h, w):
      return reshape(format: .NCHW, dimensions: [n, c, h, w], offset: offset, increments: increments)
    case let .CHWN(c, h, w, n):
      return reshape(format: .CHWN, dimensions: [c, h, w, n], offset: offset, increments: increments)
    }
  }

}

public extension DynamicGraph {

  func variable() -> AnyTensor {
    let _tensor = ccv_nnc_tensor_variable_new_impl(_graph, ccv_nnc_tensor_auto)!
    let tensor = AnyTensor(graph: self, tensor: _tensor)
    return tensor
  }

  func constant() -> AnyTensor {
    let _tensor = ccv_nnc_tensor_constant_new_impl(_graph, ccv_nnc_tensor_auto)!
    return AnyTensor(graph: self, tensor: _tensor)
  }

  func variable<Element: TensorNumeric>(_ tensor: nnc.Tensor<Element>) -> Tensor<Element> {
    let _tensor = ccv_nnc_tensor_variable_new_impl(_graph, ccv_nnc_tensor_auto)!
    ccv_nnc_tensor_variable_set(_graph, _tensor, tensor.underlying._tensor)
    // Retain the tensor until we freed the variable.
    ccv_nnc_tensor_variable_owner_hook(_graph, _tensor, { _, _, owner, ctx in
      guard owner == nil else { return }
      // No longer need to retain the tensor.
      Unmanaged<nnc._AnyTensor>.fromOpaque(ctx!).release()
    }, Unmanaged.passRetained(tensor.underlying).toOpaque())
    let tensor = Tensor<Element>(graph: self, tensor: _tensor)
    return tensor
  }

  func constant<Element: TensorNumeric>(_ tensor: nnc.Tensor<Element>) -> Tensor<Element> {
    let _tensor = ccv_nnc_tensor_constant_new_impl(_graph, ccv_nnc_tensor_auto)!
    ccv_nnc_tensor_variable_set(_graph, _tensor, tensor.underlying._tensor)
    // Retain the tensor until we freed the variable.
    ccv_nnc_tensor_variable_owner_hook(_graph, _tensor, { _, _, owner, ctx in
      guard owner == nil else { return }
      // No longer need to retain the tensor.
      Unmanaged<nnc._AnyTensor>.fromOpaque(ctx!).release()
    }, Unmanaged.passRetained(tensor.underlying).toOpaque())
    return Tensor<Element>(graph: self, tensor: _tensor)
  }

  func variable<Element: TensorNumeric>(_ device: DeviceKind, format: TensorFormat, dimensions: [Int]) -> Tensor<Element> {
    let _tensor = ccv_nnc_tensor_variable_new_impl(_graph,
      toCTensorParams(device, dataType: Element.dataType, format: format, dimensions: dimensions))!
    let tensor = Tensor<Element>(graph: self, tensor: _tensor)
    return tensor
  }

  func constant<Element: TensorNumeric>(_ device: DeviceKind, format: TensorFormat, dimensions: [Int]) -> Tensor<Element> {
    let tensor = ccv_nnc_tensor_constant_new_impl(_graph,
      toCTensorParams(device, dataType: Element.dataType, format: format, dimensions: dimensions))!
    return Tensor<Element>(graph: self, tensor: tensor)
  }

  func variable<Element: TensorNumeric>(_ device: DeviceKind, _ dimensionFormat: TensorDimensionFormat) -> Tensor<Element> {
    switch dimensionFormat {
    case let .NHWC(n, h, w, c):
      return variable(device, format: .NHWC, dimensions: [n, h, w, c])
    case let .NCHW(n, c, h, w):
      return variable(device, format: .NCHW, dimensions: [n, c, h, w])
    case let .CHWN(c, h, w, n):
      return variable(device, format: .CHWN, dimensions: [c, h, w, n])
    }
  }

  func constant<Element: TensorNumeric>(_ device: DeviceKind, _ dimensionFormat: TensorDimensionFormat) -> Tensor<Element> {
    switch dimensionFormat {
    case let .NHWC(n, h, w, c):
      return constant(device, format: .NHWC, dimensions: [n, h, w, c])
    case let .NCHW(n, c, h, w):
      return constant(device, format: .NCHW, dimensions: [n, c, h, w])
    case let .CHWN(c, h, w, n):
      return constant(device, format: .CHWN, dimensions: [c, h, w, n])
    }
  }

}
