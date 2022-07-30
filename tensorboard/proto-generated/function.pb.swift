// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: tensorboard/compat/proto/function.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _3: SwiftProtobuf.ProtobufAPIVersion_3 {}
  typealias Version = _3
}

/// A library is a set of named functions.
struct Tensorboard_FunctionDefLibrary {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var function: [Tensorboard_FunctionDef] = []

  var gradient: [Tensorboard_GradientDef] = []

  var registeredGradients: [Tensorboard_RegisteredGradient] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// A function can be instantiated when the runtime can bind every attr
/// with a value. When a GraphDef has a call to a function, it must
/// have binding for every attr defined in the signature.
///
/// TODO(zhifengc):
///   * device spec, etc.
struct Tensorboard_FunctionDef {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The definition of the function's name, arguments, return values,
  /// attrs etc.
  var signature: Tensorboard_OpDef {
    get {return _storage._signature ?? Tensorboard_OpDef()}
    set {_uniqueStorage()._signature = newValue}
  }
  /// Returns true if `signature` has been explicitly set.
  var hasSignature: Bool {return _storage._signature != nil}
  /// Clears the value of `signature`. Subsequent reads from it will return its default value.
  mutating func clearSignature() {_uniqueStorage()._signature = nil}

  /// Attributes specific to this function definition.
  var attr: Dictionary<String,Tensorboard_AttrValue> {
    get {return _storage._attr}
    set {_uniqueStorage()._attr = newValue}
  }

  var argAttr: Dictionary<UInt32,Tensorboard_FunctionDef.ArgAttrs> {
    get {return _storage._argAttr}
    set {_uniqueStorage()._argAttr = newValue}
  }

  /// Unique IDs for each resource argument, used to track aliasing resources. If
  /// Argument A and Argument B alias each other, then
  /// resource_arg_unique_ids[A.index] == resource_arg_unique_ids[B.index].
  ///
  /// If this field is empty, none of the arguments could alias; otherwise, every
  /// resource argument should have an entry in this field.
  ///
  /// When instantiated, the unique IDs will be attached to the _Arg nodes'
  /// "_resource_arg_unique_id" attribute.
  var resourceArgUniqueID: Dictionary<UInt32,UInt32> {
    get {return _storage._resourceArgUniqueID}
    set {_uniqueStorage()._resourceArgUniqueID = newValue}
  }

  /// By convention, "op" in node_def is resolved by consulting with a
  /// user-defined library first. If not resolved, "func" is assumed to
  /// be a builtin op.
  var nodeDef: [Tensorboard_NodeDef] {
    get {return _storage._nodeDef}
    set {_uniqueStorage()._nodeDef = newValue}
  }

  /// A mapping from the output arg names from `signature` to the
  /// outputs from `node_def` that should be returned by the function.
  var ret: Dictionary<String,String> {
    get {return _storage._ret}
    set {_uniqueStorage()._ret = newValue}
  }

  /// A mapping from control output names from `signature` to node names in
  /// `node_def` which should be control outputs of this function.
  var controlRet: Dictionary<String,String> {
    get {return _storage._controlRet}
    set {_uniqueStorage()._controlRet = newValue}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  /// Attributes for function arguments. These attributes are the same set of
  /// valid attributes as to _Arg nodes.
  struct ArgAttrs {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    var attr: Dictionary<String,Tensorboard_AttrValue> = [:]

    var unknownFields = SwiftProtobuf.UnknownStorage()

    init() {}
  }

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

/// GradientDef defines the gradient function of a function defined in
/// a function library.
///
/// A gradient function g (specified by gradient_func) for a function f
/// (specified by function_name) must follow the following:
///
/// The function 'f' must be a numerical function which takes N inputs
/// and produces M outputs. Its gradient function 'g', which is a
/// function taking N + M inputs and produces N outputs.
///
/// I.e. if we have
///    (y1, y2, ..., y_M) = f(x1, x2, ..., x_N),
/// then, g is
///    (dL/dx1, dL/dx2, ..., dL/dx_N) = g(x1, x2, ..., x_N,
///                                      dL/dy1, dL/dy2, ..., dL/dy_M),
/// where L is a scalar-value function of (x1, x2, ..., xN) (e.g., the
/// loss function). dL/dx_i is the partial derivative of L with respect
/// to x_i.
struct Tensorboard_GradientDef {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The function name.
  var functionName: String = String()

  /// The gradient function's name.
  var gradientFunc: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// RegisteredGradient stores a gradient function that is registered in the
/// gradients library and used in the ops of a function in the function library.
/// Unlike GradientDef, these gradients are identified by op type, and not
/// directly linked to any function.
struct Tensorboard_RegisteredGradient {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The gradient function's name.
  var gradientFunc: String = String()

  /// The gradient function's registered op type.
  var registeredOpType: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Tensorboard_FunctionDefLibrary: @unchecked Sendable {}
extension Tensorboard_FunctionDef: @unchecked Sendable {}
extension Tensorboard_FunctionDef.ArgAttrs: @unchecked Sendable {}
extension Tensorboard_GradientDef: @unchecked Sendable {}
extension Tensorboard_RegisteredGradient: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "tensorboard"

extension Tensorboard_FunctionDefLibrary: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".FunctionDefLibrary"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "function"),
    2: .same(proto: "gradient"),
    3: .standard(proto: "registered_gradients"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.function) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.gradient) }()
      case 3: try { try decoder.decodeRepeatedMessageField(value: &self.registeredGradients) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.function.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.function, fieldNumber: 1)
    }
    if !self.gradient.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.gradient, fieldNumber: 2)
    }
    if !self.registeredGradients.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.registeredGradients, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_FunctionDefLibrary, rhs: Tensorboard_FunctionDefLibrary) -> Bool {
    if lhs.function != rhs.function {return false}
    if lhs.gradient != rhs.gradient {return false}
    if lhs.registeredGradients != rhs.registeredGradients {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tensorboard_FunctionDef: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".FunctionDef"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "signature"),
    5: .same(proto: "attr"),
    7: .standard(proto: "arg_attr"),
    8: .standard(proto: "resource_arg_unique_id"),
    3: .standard(proto: "node_def"),
    4: .same(proto: "ret"),
    6: .standard(proto: "control_ret"),
  ]

  fileprivate class _StorageClass {
    var _signature: Tensorboard_OpDef? = nil
    var _attr: Dictionary<String,Tensorboard_AttrValue> = [:]
    var _argAttr: Dictionary<UInt32,Tensorboard_FunctionDef.ArgAttrs> = [:]
    var _resourceArgUniqueID: Dictionary<UInt32,UInt32> = [:]
    var _nodeDef: [Tensorboard_NodeDef] = []
    var _ret: Dictionary<String,String> = [:]
    var _controlRet: Dictionary<String,String> = [:]

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _signature = source._signature
      _attr = source._attr
      _argAttr = source._argAttr
      _resourceArgUniqueID = source._resourceArgUniqueID
      _nodeDef = source._nodeDef
      _ret = source._ret
      _controlRet = source._controlRet
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every case branch when no optimizations are
        // enabled. https://github.com/apple/swift-protobuf/issues/1034
        switch fieldNumber {
        case 1: try { try decoder.decodeSingularMessageField(value: &_storage._signature) }()
        case 3: try { try decoder.decodeRepeatedMessageField(value: &_storage._nodeDef) }()
        case 4: try { try decoder.decodeMapField(fieldType: SwiftProtobuf._ProtobufMap<SwiftProtobuf.ProtobufString,SwiftProtobuf.ProtobufString>.self, value: &_storage._ret) }()
        case 5: try { try decoder.decodeMapField(fieldType: SwiftProtobuf._ProtobufMessageMap<SwiftProtobuf.ProtobufString,Tensorboard_AttrValue>.self, value: &_storage._attr) }()
        case 6: try { try decoder.decodeMapField(fieldType: SwiftProtobuf._ProtobufMap<SwiftProtobuf.ProtobufString,SwiftProtobuf.ProtobufString>.self, value: &_storage._controlRet) }()
        case 7: try { try decoder.decodeMapField(fieldType: SwiftProtobuf._ProtobufMessageMap<SwiftProtobuf.ProtobufUInt32,Tensorboard_FunctionDef.ArgAttrs>.self, value: &_storage._argAttr) }()
        case 8: try { try decoder.decodeMapField(fieldType: SwiftProtobuf._ProtobufMap<SwiftProtobuf.ProtobufUInt32,SwiftProtobuf.ProtobufUInt32>.self, value: &_storage._resourceArgUniqueID) }()
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every if/case branch local when no optimizations
      // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
      // https://github.com/apple/swift-protobuf/issues/1182
      try { if let v = _storage._signature {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      } }()
      if !_storage._nodeDef.isEmpty {
        try visitor.visitRepeatedMessageField(value: _storage._nodeDef, fieldNumber: 3)
      }
      if !_storage._ret.isEmpty {
        try visitor.visitMapField(fieldType: SwiftProtobuf._ProtobufMap<SwiftProtobuf.ProtobufString,SwiftProtobuf.ProtobufString>.self, value: _storage._ret, fieldNumber: 4)
      }
      if !_storage._attr.isEmpty {
        try visitor.visitMapField(fieldType: SwiftProtobuf._ProtobufMessageMap<SwiftProtobuf.ProtobufString,Tensorboard_AttrValue>.self, value: _storage._attr, fieldNumber: 5)
      }
      if !_storage._controlRet.isEmpty {
        try visitor.visitMapField(fieldType: SwiftProtobuf._ProtobufMap<SwiftProtobuf.ProtobufString,SwiftProtobuf.ProtobufString>.self, value: _storage._controlRet, fieldNumber: 6)
      }
      if !_storage._argAttr.isEmpty {
        try visitor.visitMapField(fieldType: SwiftProtobuf._ProtobufMessageMap<SwiftProtobuf.ProtobufUInt32,Tensorboard_FunctionDef.ArgAttrs>.self, value: _storage._argAttr, fieldNumber: 7)
      }
      if !_storage._resourceArgUniqueID.isEmpty {
        try visitor.visitMapField(fieldType: SwiftProtobuf._ProtobufMap<SwiftProtobuf.ProtobufUInt32,SwiftProtobuf.ProtobufUInt32>.self, value: _storage._resourceArgUniqueID, fieldNumber: 8)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_FunctionDef, rhs: Tensorboard_FunctionDef) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._signature != rhs_storage._signature {return false}
        if _storage._attr != rhs_storage._attr {return false}
        if _storage._argAttr != rhs_storage._argAttr {return false}
        if _storage._resourceArgUniqueID != rhs_storage._resourceArgUniqueID {return false}
        if _storage._nodeDef != rhs_storage._nodeDef {return false}
        if _storage._ret != rhs_storage._ret {return false}
        if _storage._controlRet != rhs_storage._controlRet {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tensorboard_FunctionDef.ArgAttrs: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = Tensorboard_FunctionDef.protoMessageName + ".ArgAttrs"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "attr"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeMapField(fieldType: SwiftProtobuf._ProtobufMessageMap<SwiftProtobuf.ProtobufString,Tensorboard_AttrValue>.self, value: &self.attr) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.attr.isEmpty {
      try visitor.visitMapField(fieldType: SwiftProtobuf._ProtobufMessageMap<SwiftProtobuf.ProtobufString,Tensorboard_AttrValue>.self, value: self.attr, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_FunctionDef.ArgAttrs, rhs: Tensorboard_FunctionDef.ArgAttrs) -> Bool {
    if lhs.attr != rhs.attr {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tensorboard_GradientDef: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GradientDef"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "function_name"),
    2: .standard(proto: "gradient_func"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.functionName) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.gradientFunc) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.functionName.isEmpty {
      try visitor.visitSingularStringField(value: self.functionName, fieldNumber: 1)
    }
    if !self.gradientFunc.isEmpty {
      try visitor.visitSingularStringField(value: self.gradientFunc, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_GradientDef, rhs: Tensorboard_GradientDef) -> Bool {
    if lhs.functionName != rhs.functionName {return false}
    if lhs.gradientFunc != rhs.gradientFunc {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tensorboard_RegisteredGradient: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".RegisteredGradient"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "gradient_func"),
    2: .standard(proto: "registered_op_type"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.gradientFunc) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.registeredOpType) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.gradientFunc.isEmpty {
      try visitor.visitSingularStringField(value: self.gradientFunc, fieldNumber: 1)
    }
    if !self.registeredOpType.isEmpty {
      try visitor.visitSingularStringField(value: self.registeredOpType, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_RegisteredGradient, rhs: Tensorboard_RegisteredGradient) -> Bool {
    if lhs.gradientFunc != rhs.gradientFunc {return false}
    if lhs.registeredOpType != rhs.registeredOpType {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
