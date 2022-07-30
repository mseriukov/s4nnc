// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: tensorboard/compat/proto/attr_value.proto
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

/// Protocol buffer representing the value for an attr used to configure an Op.
/// Comment indicates the corresponding attr type.  Only the field matching the
/// attr type may be filled.
struct Tensorboard_AttrValue {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var value: Tensorboard_AttrValue.OneOf_Value? = nil

  /// "string"
  var s: Data {
    get {
      if case .s(let v)? = value {return v}
      return Data()
    }
    set {value = .s(newValue)}
  }

  /// "int"
  var i: Int64 {
    get {
      if case .i(let v)? = value {return v}
      return 0
    }
    set {value = .i(newValue)}
  }

  /// "float"
  var f: Float {
    get {
      if case .f(let v)? = value {return v}
      return 0
    }
    set {value = .f(newValue)}
  }

  /// "bool"
  var b: Bool {
    get {
      if case .b(let v)? = value {return v}
      return false
    }
    set {value = .b(newValue)}
  }

  /// "type"
  var type: Tensorboard_DataType {
    get {
      if case .type(let v)? = value {return v}
      return .dtInvalid
    }
    set {value = .type(newValue)}
  }

  /// "shape"
  var shape: Tensorboard_TensorShapeProto {
    get {
      if case .shape(let v)? = value {return v}
      return Tensorboard_TensorShapeProto()
    }
    set {value = .shape(newValue)}
  }

  /// "tensor"
  var tensor: Tensorboard_TensorProto {
    get {
      if case .tensor(let v)? = value {return v}
      return Tensorboard_TensorProto()
    }
    set {value = .tensor(newValue)}
  }

  /// any "list(...)"
  var list: Tensorboard_AttrValue.ListValue {
    get {
      if case .list(let v)? = value {return v}
      return Tensorboard_AttrValue.ListValue()
    }
    set {value = .list(newValue)}
  }

  /// "func" represents a function. func.name is a function's name or
  /// a primitive op's name. func.attr.first is the name of an attr
  /// defined for that function. func.attr.second is the value for
  /// that attr in the instantiation.
  var `func`: Tensorboard_NameAttrList {
    get {
      if case .func(let v)? = value {return v}
      return Tensorboard_NameAttrList()
    }
    set {value = .func(newValue)}
  }

  /// This is a placeholder only used in nodes defined inside a
  /// function.  It indicates the attr value will be supplied when
  /// the function is instantiated.  For example, let us suppose a
  /// node "N" in function "FN". "N" has an attr "A" with value
  /// placeholder = "foo". When FN is instantiated with attr "foo"
  /// set to "bar", the instantiated node N's attr A will have been
  /// given the value "bar".
  var placeholder: String {
    get {
      if case .placeholder(let v)? = value {return v}
      return String()
    }
    set {value = .placeholder(newValue)}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_Value: Equatable {
    /// "string"
    case s(Data)
    /// "int"
    case i(Int64)
    /// "float"
    case f(Float)
    /// "bool"
    case b(Bool)
    /// "type"
    case type(Tensorboard_DataType)
    /// "shape"
    case shape(Tensorboard_TensorShapeProto)
    /// "tensor"
    case tensor(Tensorboard_TensorProto)
    /// any "list(...)"
    case list(Tensorboard_AttrValue.ListValue)
    /// "func" represents a function. func.name is a function's name or
    /// a primitive op's name. func.attr.first is the name of an attr
    /// defined for that function. func.attr.second is the value for
    /// that attr in the instantiation.
    case `func`(Tensorboard_NameAttrList)
    /// This is a placeholder only used in nodes defined inside a
    /// function.  It indicates the attr value will be supplied when
    /// the function is instantiated.  For example, let us suppose a
    /// node "N" in function "FN". "N" has an attr "A" with value
    /// placeholder = "foo". When FN is instantiated with attr "foo"
    /// set to "bar", the instantiated node N's attr A will have been
    /// given the value "bar".
    case placeholder(String)

  }

  /// DISABLED.IfChange
  struct ListValue {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    /// "list(string)"
    var s: [Data] = []

    /// "list(int)"
    var i: [Int64] = []

    /// "list(float)"
    var f: [Float] = []

    /// "list(bool)"
    var b: [Bool] = []

    /// "list(type)"
    var type: [Tensorboard_DataType] = []

    /// "list(shape)"
    var shape: [Tensorboard_TensorShapeProto] = []

    /// "list(tensor)"
    var tensor: [Tensorboard_TensorProto] = []

    /// "list(attr)"
    var `func`: [Tensorboard_NameAttrList] = []

    var unknownFields = SwiftProtobuf.UnknownStorage()

    init() {}
  }

  init() {}
}

/// A list of attr names and their values. The whole list is attached
/// with a string name.  E.g., MatMul[T=float].
struct Tensorboard_NameAttrList {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var name: String = String()

  var attr: Dictionary<String,Tensorboard_AttrValue> = [:]

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Tensorboard_AttrValue: @unchecked Sendable {}
extension Tensorboard_AttrValue.OneOf_Value: @unchecked Sendable {}
extension Tensorboard_AttrValue.ListValue: @unchecked Sendable {}
extension Tensorboard_NameAttrList: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "tensorboard"

extension Tensorboard_AttrValue: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".AttrValue"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    2: .same(proto: "s"),
    3: .same(proto: "i"),
    4: .same(proto: "f"),
    5: .same(proto: "b"),
    6: .same(proto: "type"),
    7: .same(proto: "shape"),
    8: .same(proto: "tensor"),
    1: .same(proto: "list"),
    10: .same(proto: "func"),
    9: .same(proto: "placeholder"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try {
        var v: Tensorboard_AttrValue.ListValue?
        var hadOneofValue = false
        if let current = self.value {
          hadOneofValue = true
          if case .list(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.value = .list(v)
        }
      }()
      case 2: try {
        var v: Data?
        try decoder.decodeSingularBytesField(value: &v)
        if let v = v {
          if self.value != nil {try decoder.handleConflictingOneOf()}
          self.value = .s(v)
        }
      }()
      case 3: try {
        var v: Int64?
        try decoder.decodeSingularInt64Field(value: &v)
        if let v = v {
          if self.value != nil {try decoder.handleConflictingOneOf()}
          self.value = .i(v)
        }
      }()
      case 4: try {
        var v: Float?
        try decoder.decodeSingularFloatField(value: &v)
        if let v = v {
          if self.value != nil {try decoder.handleConflictingOneOf()}
          self.value = .f(v)
        }
      }()
      case 5: try {
        var v: Bool?
        try decoder.decodeSingularBoolField(value: &v)
        if let v = v {
          if self.value != nil {try decoder.handleConflictingOneOf()}
          self.value = .b(v)
        }
      }()
      case 6: try {
        var v: Tensorboard_DataType?
        try decoder.decodeSingularEnumField(value: &v)
        if let v = v {
          if self.value != nil {try decoder.handleConflictingOneOf()}
          self.value = .type(v)
        }
      }()
      case 7: try {
        var v: Tensorboard_TensorShapeProto?
        var hadOneofValue = false
        if let current = self.value {
          hadOneofValue = true
          if case .shape(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.value = .shape(v)
        }
      }()
      case 8: try {
        var v: Tensorboard_TensorProto?
        var hadOneofValue = false
        if let current = self.value {
          hadOneofValue = true
          if case .tensor(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.value = .tensor(v)
        }
      }()
      case 9: try {
        var v: String?
        try decoder.decodeSingularStringField(value: &v)
        if let v = v {
          if self.value != nil {try decoder.handleConflictingOneOf()}
          self.value = .placeholder(v)
        }
      }()
      case 10: try {
        var v: Tensorboard_NameAttrList?
        var hadOneofValue = false
        if let current = self.value {
          hadOneofValue = true
          if case .func(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.value = .func(v)
        }
      }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    switch self.value {
    case .list?: try {
      guard case .list(let v)? = self.value else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }()
    case .s?: try {
      guard case .s(let v)? = self.value else { preconditionFailure() }
      try visitor.visitSingularBytesField(value: v, fieldNumber: 2)
    }()
    case .i?: try {
      guard case .i(let v)? = self.value else { preconditionFailure() }
      try visitor.visitSingularInt64Field(value: v, fieldNumber: 3)
    }()
    case .f?: try {
      guard case .f(let v)? = self.value else { preconditionFailure() }
      try visitor.visitSingularFloatField(value: v, fieldNumber: 4)
    }()
    case .b?: try {
      guard case .b(let v)? = self.value else { preconditionFailure() }
      try visitor.visitSingularBoolField(value: v, fieldNumber: 5)
    }()
    case .type?: try {
      guard case .type(let v)? = self.value else { preconditionFailure() }
      try visitor.visitSingularEnumField(value: v, fieldNumber: 6)
    }()
    case .shape?: try {
      guard case .shape(let v)? = self.value else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
    }()
    case .tensor?: try {
      guard case .tensor(let v)? = self.value else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 8)
    }()
    case .placeholder?: try {
      guard case .placeholder(let v)? = self.value else { preconditionFailure() }
      try visitor.visitSingularStringField(value: v, fieldNumber: 9)
    }()
    case .func?: try {
      guard case .func(let v)? = self.value else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 10)
    }()
    case nil: break
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_AttrValue, rhs: Tensorboard_AttrValue) -> Bool {
    if lhs.value != rhs.value {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tensorboard_AttrValue.ListValue: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = Tensorboard_AttrValue.protoMessageName + ".ListValue"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    2: .same(proto: "s"),
    3: .same(proto: "i"),
    4: .same(proto: "f"),
    5: .same(proto: "b"),
    6: .same(proto: "type"),
    7: .same(proto: "shape"),
    8: .same(proto: "tensor"),
    9: .same(proto: "func"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 2: try { try decoder.decodeRepeatedBytesField(value: &self.s) }()
      case 3: try { try decoder.decodeRepeatedInt64Field(value: &self.i) }()
      case 4: try { try decoder.decodeRepeatedFloatField(value: &self.f) }()
      case 5: try { try decoder.decodeRepeatedBoolField(value: &self.b) }()
      case 6: try { try decoder.decodeRepeatedEnumField(value: &self.type) }()
      case 7: try { try decoder.decodeRepeatedMessageField(value: &self.shape) }()
      case 8: try { try decoder.decodeRepeatedMessageField(value: &self.tensor) }()
      case 9: try { try decoder.decodeRepeatedMessageField(value: &self.`func`) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.s.isEmpty {
      try visitor.visitRepeatedBytesField(value: self.s, fieldNumber: 2)
    }
    if !self.i.isEmpty {
      try visitor.visitPackedInt64Field(value: self.i, fieldNumber: 3)
    }
    if !self.f.isEmpty {
      try visitor.visitPackedFloatField(value: self.f, fieldNumber: 4)
    }
    if !self.b.isEmpty {
      try visitor.visitPackedBoolField(value: self.b, fieldNumber: 5)
    }
    if !self.type.isEmpty {
      try visitor.visitPackedEnumField(value: self.type, fieldNumber: 6)
    }
    if !self.shape.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.shape, fieldNumber: 7)
    }
    if !self.tensor.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.tensor, fieldNumber: 8)
    }
    if !self.`func`.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.`func`, fieldNumber: 9)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_AttrValue.ListValue, rhs: Tensorboard_AttrValue.ListValue) -> Bool {
    if lhs.s != rhs.s {return false}
    if lhs.i != rhs.i {return false}
    if lhs.f != rhs.f {return false}
    if lhs.b != rhs.b {return false}
    if lhs.type != rhs.type {return false}
    if lhs.shape != rhs.shape {return false}
    if lhs.tensor != rhs.tensor {return false}
    if lhs.`func` != rhs.`func` {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tensorboard_NameAttrList: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".NameAttrList"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "name"),
    2: .same(proto: "attr"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.name) }()
      case 2: try { try decoder.decodeMapField(fieldType: SwiftProtobuf._ProtobufMessageMap<SwiftProtobuf.ProtobufString,Tensorboard_AttrValue>.self, value: &self.attr) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 1)
    }
    if !self.attr.isEmpty {
      try visitor.visitMapField(fieldType: SwiftProtobuf._ProtobufMessageMap<SwiftProtobuf.ProtobufString,Tensorboard_AttrValue>.self, value: self.attr, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_NameAttrList, rhs: Tensorboard_NameAttrList) -> Bool {
    if lhs.name != rhs.name {return false}
    if lhs.attr != rhs.attr {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
