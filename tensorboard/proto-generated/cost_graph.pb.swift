// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: tensorboard/compat/proto/cost_graph.proto
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

struct Tensorboard_CostGraphDef {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var node: [Tensorboard_CostGraphDef.Node] = []

  var cost: [Tensorboard_CostGraphDef.AggregatedCost] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  struct Node {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    /// The name of the node. Names are globally unique.
    var name: String = String()

    /// The device of the node. Can be empty if the node is mapped to the
    /// default partition or partitioning hasn't been run yet.
    var device: String = String()

    /// The id of the node. Node ids are only unique inside a partition.
    var id: Int32 = 0

    var inputInfo: [Tensorboard_CostGraphDef.Node.InputInfo] = []

    var outputInfo: [Tensorboard_CostGraphDef.Node.OutputInfo] = []

    /// Temporary memory used by this node.
    var temporaryMemorySize: Int64 = 0

    /// Persistent memory used by this node.
    var persistentMemorySize: Int64 = 0

    var hostTempMemorySize: Int64 = 0

    var deviceTempMemorySize: Int64 = 0

    var devicePersistentMemorySize: Int64 = 0

    /// Estimate of the computational cost of this node, in microseconds.
    var computeCost: Int64 = 0

    /// Analytical estimate of the computational cost of this node, in
    /// microseconds.
    var computeTime: Int64 = 0

    /// Analytical estimate of the memory access cost of this node, in
    /// microseconds.
    var memoryTime: Int64 = 0

    /// If true, the output is permanent: it can't be discarded, because this
    /// node is part of the "final output". Nodes may depend on final nodes.
    var isFinal: Bool = false

    /// Ids of the control inputs for this node.
    var controlInput: [Int32] = []

    /// Are the costs inaccurate?
    var inaccurate: Bool = false

    var unknownFields = SwiftProtobuf.UnknownStorage()

    /// Inputs of this node. They must be executed before this node can be
    /// executed. An input is a particular output of another node, specified
    /// by the node id and the output index.
    struct InputInfo {
      // SwiftProtobuf.Message conformance is added in an extension below. See the
      // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
      // methods supported on all messages.

      var precedingNode: Int32 = 0

      var precedingPort: Int32 = 0

      var unknownFields = SwiftProtobuf.UnknownStorage()

      init() {}
    }

    /// Outputs of this node.
    struct OutputInfo {
      // SwiftProtobuf.Message conformance is added in an extension below. See the
      // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
      // methods supported on all messages.

      var size: Int64 = 0

      /// If >= 0, the output is an alias of an input. Note that an alias input
      /// may itself be an alias. The algorithm will therefore need to follow
      /// those pointers.
      var aliasInputPort: Int64 = 0

      var shape: Tensorboard_TensorShapeProto {
        get {return _shape ?? Tensorboard_TensorShapeProto()}
        set {_shape = newValue}
      }
      /// Returns true if `shape` has been explicitly set.
      var hasShape: Bool {return self._shape != nil}
      /// Clears the value of `shape`. Subsequent reads from it will return its default value.
      mutating func clearShape() {self._shape = nil}

      var dtype: Tensorboard_DataType = .dtInvalid

      var unknownFields = SwiftProtobuf.UnknownStorage()

      init() {}

      fileprivate var _shape: Tensorboard_TensorShapeProto? = nil
    }

    init() {}
  }

  /// Total cost of this graph, typically used for balancing decisions.
  struct AggregatedCost {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    /// Aggregated cost value.
    var cost: Float = 0

    /// Aggregated cost dimension (e.g. 'memory', 'compute', 'network').
    var dimension: String = String()

    var unknownFields = SwiftProtobuf.UnknownStorage()

    init() {}
  }

  init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Tensorboard_CostGraphDef: @unchecked Sendable {}
extension Tensorboard_CostGraphDef.Node: @unchecked Sendable {}
extension Tensorboard_CostGraphDef.Node.InputInfo: @unchecked Sendable {}
extension Tensorboard_CostGraphDef.Node.OutputInfo: @unchecked Sendable {}
extension Tensorboard_CostGraphDef.AggregatedCost: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "tensorboard"

extension Tensorboard_CostGraphDef: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".CostGraphDef"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "node"),
    2: .same(proto: "cost"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.node) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.cost) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.node.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.node, fieldNumber: 1)
    }
    if !self.cost.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.cost, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_CostGraphDef, rhs: Tensorboard_CostGraphDef) -> Bool {
    if lhs.node != rhs.node {return false}
    if lhs.cost != rhs.cost {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tensorboard_CostGraphDef.Node: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = Tensorboard_CostGraphDef.protoMessageName + ".Node"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "name"),
    2: .same(proto: "device"),
    3: .same(proto: "id"),
    4: .standard(proto: "input_info"),
    5: .standard(proto: "output_info"),
    6: .standard(proto: "temporary_memory_size"),
    12: .standard(proto: "persistent_memory_size"),
    10: .standard(proto: "host_temp_memory_size"),
    11: .standard(proto: "device_temp_memory_size"),
    16: .standard(proto: "device_persistent_memory_size"),
    9: .standard(proto: "compute_cost"),
    14: .standard(proto: "compute_time"),
    15: .standard(proto: "memory_time"),
    7: .standard(proto: "is_final"),
    8: .standard(proto: "control_input"),
    17: .same(proto: "inaccurate"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.name) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.device) }()
      case 3: try { try decoder.decodeSingularInt32Field(value: &self.id) }()
      case 4: try { try decoder.decodeRepeatedMessageField(value: &self.inputInfo) }()
      case 5: try { try decoder.decodeRepeatedMessageField(value: &self.outputInfo) }()
      case 6: try { try decoder.decodeSingularInt64Field(value: &self.temporaryMemorySize) }()
      case 7: try { try decoder.decodeSingularBoolField(value: &self.isFinal) }()
      case 8: try { try decoder.decodeRepeatedInt32Field(value: &self.controlInput) }()
      case 9: try { try decoder.decodeSingularInt64Field(value: &self.computeCost) }()
      case 10: try { try decoder.decodeSingularInt64Field(value: &self.hostTempMemorySize) }()
      case 11: try { try decoder.decodeSingularInt64Field(value: &self.deviceTempMemorySize) }()
      case 12: try { try decoder.decodeSingularInt64Field(value: &self.persistentMemorySize) }()
      case 14: try { try decoder.decodeSingularInt64Field(value: &self.computeTime) }()
      case 15: try { try decoder.decodeSingularInt64Field(value: &self.memoryTime) }()
      case 16: try { try decoder.decodeSingularInt64Field(value: &self.devicePersistentMemorySize) }()
      case 17: try { try decoder.decodeSingularBoolField(value: &self.inaccurate) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 1)
    }
    if !self.device.isEmpty {
      try visitor.visitSingularStringField(value: self.device, fieldNumber: 2)
    }
    if self.id != 0 {
      try visitor.visitSingularInt32Field(value: self.id, fieldNumber: 3)
    }
    if !self.inputInfo.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.inputInfo, fieldNumber: 4)
    }
    if !self.outputInfo.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.outputInfo, fieldNumber: 5)
    }
    if self.temporaryMemorySize != 0 {
      try visitor.visitSingularInt64Field(value: self.temporaryMemorySize, fieldNumber: 6)
    }
    if self.isFinal != false {
      try visitor.visitSingularBoolField(value: self.isFinal, fieldNumber: 7)
    }
    if !self.controlInput.isEmpty {
      try visitor.visitPackedInt32Field(value: self.controlInput, fieldNumber: 8)
    }
    if self.computeCost != 0 {
      try visitor.visitSingularInt64Field(value: self.computeCost, fieldNumber: 9)
    }
    if self.hostTempMemorySize != 0 {
      try visitor.visitSingularInt64Field(value: self.hostTempMemorySize, fieldNumber: 10)
    }
    if self.deviceTempMemorySize != 0 {
      try visitor.visitSingularInt64Field(value: self.deviceTempMemorySize, fieldNumber: 11)
    }
    if self.persistentMemorySize != 0 {
      try visitor.visitSingularInt64Field(value: self.persistentMemorySize, fieldNumber: 12)
    }
    if self.computeTime != 0 {
      try visitor.visitSingularInt64Field(value: self.computeTime, fieldNumber: 14)
    }
    if self.memoryTime != 0 {
      try visitor.visitSingularInt64Field(value: self.memoryTime, fieldNumber: 15)
    }
    if self.devicePersistentMemorySize != 0 {
      try visitor.visitSingularInt64Field(value: self.devicePersistentMemorySize, fieldNumber: 16)
    }
    if self.inaccurate != false {
      try visitor.visitSingularBoolField(value: self.inaccurate, fieldNumber: 17)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_CostGraphDef.Node, rhs: Tensorboard_CostGraphDef.Node) -> Bool {
    if lhs.name != rhs.name {return false}
    if lhs.device != rhs.device {return false}
    if lhs.id != rhs.id {return false}
    if lhs.inputInfo != rhs.inputInfo {return false}
    if lhs.outputInfo != rhs.outputInfo {return false}
    if lhs.temporaryMemorySize != rhs.temporaryMemorySize {return false}
    if lhs.persistentMemorySize != rhs.persistentMemorySize {return false}
    if lhs.hostTempMemorySize != rhs.hostTempMemorySize {return false}
    if lhs.deviceTempMemorySize != rhs.deviceTempMemorySize {return false}
    if lhs.devicePersistentMemorySize != rhs.devicePersistentMemorySize {return false}
    if lhs.computeCost != rhs.computeCost {return false}
    if lhs.computeTime != rhs.computeTime {return false}
    if lhs.memoryTime != rhs.memoryTime {return false}
    if lhs.isFinal != rhs.isFinal {return false}
    if lhs.controlInput != rhs.controlInput {return false}
    if lhs.inaccurate != rhs.inaccurate {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tensorboard_CostGraphDef.Node.InputInfo: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = Tensorboard_CostGraphDef.Node.protoMessageName + ".InputInfo"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "preceding_node"),
    2: .standard(proto: "preceding_port"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.precedingNode) }()
      case 2: try { try decoder.decodeSingularInt32Field(value: &self.precedingPort) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.precedingNode != 0 {
      try visitor.visitSingularInt32Field(value: self.precedingNode, fieldNumber: 1)
    }
    if self.precedingPort != 0 {
      try visitor.visitSingularInt32Field(value: self.precedingPort, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_CostGraphDef.Node.InputInfo, rhs: Tensorboard_CostGraphDef.Node.InputInfo) -> Bool {
    if lhs.precedingNode != rhs.precedingNode {return false}
    if lhs.precedingPort != rhs.precedingPort {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tensorboard_CostGraphDef.Node.OutputInfo: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = Tensorboard_CostGraphDef.Node.protoMessageName + ".OutputInfo"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "size"),
    2: .standard(proto: "alias_input_port"),
    3: .same(proto: "shape"),
    4: .same(proto: "dtype"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.size) }()
      case 2: try { try decoder.decodeSingularInt64Field(value: &self.aliasInputPort) }()
      case 3: try { try decoder.decodeSingularMessageField(value: &self._shape) }()
      case 4: try { try decoder.decodeSingularEnumField(value: &self.dtype) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if self.size != 0 {
      try visitor.visitSingularInt64Field(value: self.size, fieldNumber: 1)
    }
    if self.aliasInputPort != 0 {
      try visitor.visitSingularInt64Field(value: self.aliasInputPort, fieldNumber: 2)
    }
    try { if let v = self._shape {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    } }()
    if self.dtype != .dtInvalid {
      try visitor.visitSingularEnumField(value: self.dtype, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_CostGraphDef.Node.OutputInfo, rhs: Tensorboard_CostGraphDef.Node.OutputInfo) -> Bool {
    if lhs.size != rhs.size {return false}
    if lhs.aliasInputPort != rhs.aliasInputPort {return false}
    if lhs._shape != rhs._shape {return false}
    if lhs.dtype != rhs.dtype {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tensorboard_CostGraphDef.AggregatedCost: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = Tensorboard_CostGraphDef.protoMessageName + ".AggregatedCost"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "cost"),
    2: .same(proto: "dimension"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularFloatField(value: &self.cost) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.dimension) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.cost != 0 {
      try visitor.visitSingularFloatField(value: self.cost, fieldNumber: 1)
    }
    if !self.dimension.isEmpty {
      try visitor.visitSingularStringField(value: self.dimension, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_CostGraphDef.AggregatedCost, rhs: Tensorboard_CostGraphDef.AggregatedCost) -> Bool {
    if lhs.cost != rhs.cost {return false}
    if lhs.dimension != rhs.dimension {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
