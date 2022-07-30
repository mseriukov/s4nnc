// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: tensorboard/compat/proto/event.proto
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

/// Current health status of a worker.
enum Tensorboard_WorkerHealth: SwiftProtobuf.Enum {
  typealias RawValue = Int

  /// By default a worker is healthy.
  case ok // = 0
  case receivedShutdownSignal // = 1
  case internalError // = 2

  /// Worker has been instructed to shutdown after a timeout.
  case shuttingDown // = 3
  case UNRECOGNIZED(Int)

  init() {
    self = .ok
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .ok
    case 1: self = .receivedShutdownSignal
    case 2: self = .internalError
    case 3: self = .shuttingDown
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .ok: return 0
    case .receivedShutdownSignal: return 1
    case .internalError: return 2
    case .shuttingDown: return 3
    case .UNRECOGNIZED(let i): return i
    }
  }

  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Tensorboard_WorkerHealth] = [
    .ok,
    .receivedShutdownSignal,
    .internalError,
    .shuttingDown,
  ]

}

/// Indicates the behavior of the worker when an internal error or shutdown
/// signal is received.
enum Tensorboard_WorkerShutdownMode: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case `default` // = 0
  case notConfigured // = 1
  case waitForCoordinator // = 2
  case shutdownAfterTimeout // = 3
  case UNRECOGNIZED(Int)

  init() {
    self = .default
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .default
    case 1: self = .notConfigured
    case 2: self = .waitForCoordinator
    case 3: self = .shutdownAfterTimeout
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .default: return 0
    case .notConfigured: return 1
    case .waitForCoordinator: return 2
    case .shutdownAfterTimeout: return 3
    case .UNRECOGNIZED(let i): return i
    }
  }

  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Tensorboard_WorkerShutdownMode] = [
    .default,
    .notConfigured,
    .waitForCoordinator,
    .shutdownAfterTimeout,
  ]

}

/// Protocol buffer representing an event that happened during
/// the execution of a Brain model.
struct Tensorboard_Event {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Timestamp of the event.
  var wallTime: Double = 0

  /// Global step of the event.
  var step: Int64 = 0

  var what: Tensorboard_Event.OneOf_What? = nil

  /// An event file was started, with the specified version.
  /// This is use to identify the contents of the record IO files
  /// easily.  Current version is "brain.Event:2".  All versions
  /// start with "brain.Event:".
  var fileVersion: String {
    get {
      if case .fileVersion(let v)? = what {return v}
      return String()
    }
    set {what = .fileVersion(newValue)}
  }

  /// An encoded version of a GraphDef.
  var graphDef: Data {
    get {
      if case .graphDef(let v)? = what {return v}
      return Data()
    }
    set {what = .graphDef(newValue)}
  }

  /// A summary was generated.
  var summary: Tensorboard_Summary {
    get {
      if case .summary(let v)? = what {return v}
      return Tensorboard_Summary()
    }
    set {what = .summary(newValue)}
  }

  /// The user output a log message. This was theoretically used by the defunct
  /// tensorboard_logging module, which has since been removed; this field is
  /// now deprecated and should not be used.
  var logMessage: Tensorboard_LogMessage {
    get {
      if case .logMessage(let v)? = what {return v}
      return Tensorboard_LogMessage()
    }
    set {what = .logMessage(newValue)}
  }

  /// The state of the session which can be used for restarting after crashes.
  var sessionLog: Tensorboard_SessionLog {
    get {
      if case .sessionLog(let v)? = what {return v}
      return Tensorboard_SessionLog()
    }
    set {what = .sessionLog(newValue)}
  }

  /// The metadata returned by running a session.run() call.
  var taggedRunMetadata: Tensorboard_TaggedRunMetadata {
    get {
      if case .taggedRunMetadata(let v)? = what {return v}
      return Tensorboard_TaggedRunMetadata()
    }
    set {what = .taggedRunMetadata(newValue)}
  }

  /// An encoded version of a MetaGraphDef.
  var metaGraphDef: Data {
    get {
      if case .metaGraphDef(let v)? = what {return v}
      return Data()
    }
    set {what = .metaGraphDef(newValue)}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_What: Equatable {
    /// An event file was started, with the specified version.
    /// This is use to identify the contents of the record IO files
    /// easily.  Current version is "brain.Event:2".  All versions
    /// start with "brain.Event:".
    case fileVersion(String)
    /// An encoded version of a GraphDef.
    case graphDef(Data)
    /// A summary was generated.
    case summary(Tensorboard_Summary)
    /// The user output a log message. This was theoretically used by the defunct
    /// tensorboard_logging module, which has since been removed; this field is
    /// now deprecated and should not be used.
    case logMessage(Tensorboard_LogMessage)
    /// The state of the session which can be used for restarting after crashes.
    case sessionLog(Tensorboard_SessionLog)
    /// The metadata returned by running a session.run() call.
    case taggedRunMetadata(Tensorboard_TaggedRunMetadata)
    /// An encoded version of a MetaGraphDef.
    case metaGraphDef(Data)

  }

  init() {}
}

/// Protocol buffer used for logging messages to the events file.
///
/// This was theoretically used by the defunct tensorboard_logging module, which
/// has been removed; this message is now deprecated and should not be used.
struct Tensorboard_LogMessage {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var level: Tensorboard_LogMessage.Level = .unknown

  var message: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum Level: SwiftProtobuf.Enum {
    typealias RawValue = Int
    case unknown // = 0

    /// Note: The logging level 10 cannot be named DEBUG. Some software
    /// projects compile their C/C++ code with -DDEBUG in debug builds. So the
    /// C++ code generated from this file should not have an identifier named
    /// DEBUG.
    case debugging // = 10
    case info // = 20
    case warn // = 30
    case error // = 40
    case fatal // = 50
    case UNRECOGNIZED(Int)

    init() {
      self = .unknown
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .unknown
      case 10: self = .debugging
      case 20: self = .info
      case 30: self = .warn
      case 40: self = .error
      case 50: self = .fatal
      default: self = .UNRECOGNIZED(rawValue)
      }
    }

    var rawValue: Int {
      switch self {
      case .unknown: return 0
      case .debugging: return 10
      case .info: return 20
      case .warn: return 30
      case .error: return 40
      case .fatal: return 50
      case .UNRECOGNIZED(let i): return i
      }
    }

    // The compiler won't synthesize support with the UNRECOGNIZED case.
    static var allCases: [Tensorboard_LogMessage.Level] = [
      .unknown,
      .debugging,
      .info,
      .warn,
      .error,
      .fatal,
    ]

  }

  init() {}
}

/// Protocol buffer used for logging session state.
struct Tensorboard_SessionLog {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var status: Tensorboard_SessionLog.SessionStatus = .statusUnspecified

  /// This checkpoint_path contains both the path and filename.
  var checkpointPath: String = String()

  var msg: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum SessionStatus: SwiftProtobuf.Enum {
    typealias RawValue = Int
    case statusUnspecified // = 0
    case start // = 1
    case stop // = 2
    case checkpoint // = 3
    case UNRECOGNIZED(Int)

    init() {
      self = .statusUnspecified
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .statusUnspecified
      case 1: self = .start
      case 2: self = .stop
      case 3: self = .checkpoint
      default: self = .UNRECOGNIZED(rawValue)
      }
    }

    var rawValue: Int {
      switch self {
      case .statusUnspecified: return 0
      case .start: return 1
      case .stop: return 2
      case .checkpoint: return 3
      case .UNRECOGNIZED(let i): return i
      }
    }

    // The compiler won't synthesize support with the UNRECOGNIZED case.
    static var allCases: [Tensorboard_SessionLog.SessionStatus] = [
      .statusUnspecified,
      .start,
      .stop,
      .checkpoint,
    ]

  }

  init() {}
}

/// For logging the metadata output for a single session.run() call.
struct Tensorboard_TaggedRunMetadata {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Tag name associated with this metadata.
  var tag: String = String()

  /// Byte-encoded version of the `RunMetadata` proto in order to allow lazy
  /// deserialization.
  var runMetadata: Data = Data()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Tensorboard_WatchdogConfig {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var timeoutMs: Int64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Tensorboard_RequestedExitCode {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var exitCode: Int32 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Tensorboard_WorkerHeartbeatRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var shutdownMode: Tensorboard_WorkerShutdownMode = .default

  var watchdogConfig: Tensorboard_WatchdogConfig {
    get {return _watchdogConfig ?? Tensorboard_WatchdogConfig()}
    set {_watchdogConfig = newValue}
  }
  /// Returns true if `watchdogConfig` has been explicitly set.
  var hasWatchdogConfig: Bool {return self._watchdogConfig != nil}
  /// Clears the value of `watchdogConfig`. Subsequent reads from it will return its default value.
  mutating func clearWatchdogConfig() {self._watchdogConfig = nil}

  var exitCode: Tensorboard_RequestedExitCode {
    get {return _exitCode ?? Tensorboard_RequestedExitCode()}
    set {_exitCode = newValue}
  }
  /// Returns true if `exitCode` has been explicitly set.
  var hasExitCode: Bool {return self._exitCode != nil}
  /// Clears the value of `exitCode`. Subsequent reads from it will return its default value.
  mutating func clearExitCode() {self._exitCode = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _watchdogConfig: Tensorboard_WatchdogConfig? = nil
  fileprivate var _exitCode: Tensorboard_RequestedExitCode? = nil
}

struct Tensorboard_WorkerHeartbeatResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var healthStatus: Tensorboard_WorkerHealth = .ok

  var workerLog: [Tensorboard_Event] = []

  var hostname: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Tensorboard_Event: @unchecked Sendable {}
extension Tensorboard_Event.OneOf_What: @unchecked Sendable {}
extension Tensorboard_LogMessage: @unchecked Sendable {}
extension Tensorboard_SessionLog: @unchecked Sendable {}
extension Tensorboard_TaggedRunMetadata: @unchecked Sendable {}
extension Tensorboard_WatchdogConfig: @unchecked Sendable {}
extension Tensorboard_RequestedExitCode: @unchecked Sendable {}
extension Tensorboard_WorkerHeartbeatRequest: @unchecked Sendable {}
extension Tensorboard_WorkerHeartbeatResponse: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "tensorboard"

extension Tensorboard_WorkerHealth: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "OK"),
    1: .same(proto: "RECEIVED_SHUTDOWN_SIGNAL"),
    2: .same(proto: "INTERNAL_ERROR"),
    3: .same(proto: "SHUTTING_DOWN"),
  ]
}

extension Tensorboard_WorkerShutdownMode: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "DEFAULT"),
    1: .same(proto: "NOT_CONFIGURED"),
    2: .same(proto: "WAIT_FOR_COORDINATOR"),
    3: .same(proto: "SHUTDOWN_AFTER_TIMEOUT"),
  ]
}

extension Tensorboard_Event: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Event"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "wall_time"),
    2: .same(proto: "step"),
    3: .standard(proto: "file_version"),
    4: .standard(proto: "graph_def"),
    5: .same(proto: "summary"),
    6: .standard(proto: "log_message"),
    7: .standard(proto: "session_log"),
    8: .standard(proto: "tagged_run_metadata"),
    9: .standard(proto: "meta_graph_def"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularDoubleField(value: &self.wallTime) }()
      case 2: try { try decoder.decodeSingularInt64Field(value: &self.step) }()
      case 3: try {
        var v: String?
        try decoder.decodeSingularStringField(value: &v)
        if let v = v {
          if self.what != nil {try decoder.handleConflictingOneOf()}
          self.what = .fileVersion(v)
        }
      }()
      case 4: try {
        var v: Data?
        try decoder.decodeSingularBytesField(value: &v)
        if let v = v {
          if self.what != nil {try decoder.handleConflictingOneOf()}
          self.what = .graphDef(v)
        }
      }()
      case 5: try {
        var v: Tensorboard_Summary?
        var hadOneofValue = false
        if let current = self.what {
          hadOneofValue = true
          if case .summary(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.what = .summary(v)
        }
      }()
      case 6: try {
        var v: Tensorboard_LogMessage?
        var hadOneofValue = false
        if let current = self.what {
          hadOneofValue = true
          if case .logMessage(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.what = .logMessage(v)
        }
      }()
      case 7: try {
        var v: Tensorboard_SessionLog?
        var hadOneofValue = false
        if let current = self.what {
          hadOneofValue = true
          if case .sessionLog(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.what = .sessionLog(v)
        }
      }()
      case 8: try {
        var v: Tensorboard_TaggedRunMetadata?
        var hadOneofValue = false
        if let current = self.what {
          hadOneofValue = true
          if case .taggedRunMetadata(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.what = .taggedRunMetadata(v)
        }
      }()
      case 9: try {
        var v: Data?
        try decoder.decodeSingularBytesField(value: &v)
        if let v = v {
          if self.what != nil {try decoder.handleConflictingOneOf()}
          self.what = .metaGraphDef(v)
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
    if self.wallTime != 0 {
      try visitor.visitSingularDoubleField(value: self.wallTime, fieldNumber: 1)
    }
    if self.step != 0 {
      try visitor.visitSingularInt64Field(value: self.step, fieldNumber: 2)
    }
    switch self.what {
    case .fileVersion?: try {
      guard case .fileVersion(let v)? = self.what else { preconditionFailure() }
      try visitor.visitSingularStringField(value: v, fieldNumber: 3)
    }()
    case .graphDef?: try {
      guard case .graphDef(let v)? = self.what else { preconditionFailure() }
      try visitor.visitSingularBytesField(value: v, fieldNumber: 4)
    }()
    case .summary?: try {
      guard case .summary(let v)? = self.what else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    }()
    case .logMessage?: try {
      guard case .logMessage(let v)? = self.what else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
    }()
    case .sessionLog?: try {
      guard case .sessionLog(let v)? = self.what else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
    }()
    case .taggedRunMetadata?: try {
      guard case .taggedRunMetadata(let v)? = self.what else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 8)
    }()
    case .metaGraphDef?: try {
      guard case .metaGraphDef(let v)? = self.what else { preconditionFailure() }
      try visitor.visitSingularBytesField(value: v, fieldNumber: 9)
    }()
    case nil: break
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_Event, rhs: Tensorboard_Event) -> Bool {
    if lhs.wallTime != rhs.wallTime {return false}
    if lhs.step != rhs.step {return false}
    if lhs.what != rhs.what {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tensorboard_LogMessage: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".LogMessage"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "level"),
    2: .same(proto: "message"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularEnumField(value: &self.level) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.message) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.level != .unknown {
      try visitor.visitSingularEnumField(value: self.level, fieldNumber: 1)
    }
    if !self.message.isEmpty {
      try visitor.visitSingularStringField(value: self.message, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_LogMessage, rhs: Tensorboard_LogMessage) -> Bool {
    if lhs.level != rhs.level {return false}
    if lhs.message != rhs.message {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tensorboard_LogMessage.Level: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "UNKNOWN"),
    10: .same(proto: "DEBUGGING"),
    20: .same(proto: "INFO"),
    30: .same(proto: "WARN"),
    40: .same(proto: "ERROR"),
    50: .same(proto: "FATAL"),
  ]
}

extension Tensorboard_SessionLog: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".SessionLog"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "status"),
    2: .standard(proto: "checkpoint_path"),
    3: .same(proto: "msg"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularEnumField(value: &self.status) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.checkpointPath) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.msg) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.status != .statusUnspecified {
      try visitor.visitSingularEnumField(value: self.status, fieldNumber: 1)
    }
    if !self.checkpointPath.isEmpty {
      try visitor.visitSingularStringField(value: self.checkpointPath, fieldNumber: 2)
    }
    if !self.msg.isEmpty {
      try visitor.visitSingularStringField(value: self.msg, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_SessionLog, rhs: Tensorboard_SessionLog) -> Bool {
    if lhs.status != rhs.status {return false}
    if lhs.checkpointPath != rhs.checkpointPath {return false}
    if lhs.msg != rhs.msg {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tensorboard_SessionLog.SessionStatus: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "STATUS_UNSPECIFIED"),
    1: .same(proto: "START"),
    2: .same(proto: "STOP"),
    3: .same(proto: "CHECKPOINT"),
  ]
}

extension Tensorboard_TaggedRunMetadata: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".TaggedRunMetadata"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "tag"),
    2: .standard(proto: "run_metadata"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.tag) }()
      case 2: try { try decoder.decodeSingularBytesField(value: &self.runMetadata) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.tag.isEmpty {
      try visitor.visitSingularStringField(value: self.tag, fieldNumber: 1)
    }
    if !self.runMetadata.isEmpty {
      try visitor.visitSingularBytesField(value: self.runMetadata, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_TaggedRunMetadata, rhs: Tensorboard_TaggedRunMetadata) -> Bool {
    if lhs.tag != rhs.tag {return false}
    if lhs.runMetadata != rhs.runMetadata {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tensorboard_WatchdogConfig: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".WatchdogConfig"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "timeout_ms"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.timeoutMs) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.timeoutMs != 0 {
      try visitor.visitSingularInt64Field(value: self.timeoutMs, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_WatchdogConfig, rhs: Tensorboard_WatchdogConfig) -> Bool {
    if lhs.timeoutMs != rhs.timeoutMs {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tensorboard_RequestedExitCode: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".RequestedExitCode"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "exit_code"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.exitCode) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.exitCode != 0 {
      try visitor.visitSingularInt32Field(value: self.exitCode, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_RequestedExitCode, rhs: Tensorboard_RequestedExitCode) -> Bool {
    if lhs.exitCode != rhs.exitCode {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tensorboard_WorkerHeartbeatRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".WorkerHeartbeatRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "shutdown_mode"),
    2: .standard(proto: "watchdog_config"),
    3: .standard(proto: "exit_code"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularEnumField(value: &self.shutdownMode) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._watchdogConfig) }()
      case 3: try { try decoder.decodeSingularMessageField(value: &self._exitCode) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if self.shutdownMode != .default {
      try visitor.visitSingularEnumField(value: self.shutdownMode, fieldNumber: 1)
    }
    try { if let v = self._watchdogConfig {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._exitCode {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_WorkerHeartbeatRequest, rhs: Tensorboard_WorkerHeartbeatRequest) -> Bool {
    if lhs.shutdownMode != rhs.shutdownMode {return false}
    if lhs._watchdogConfig != rhs._watchdogConfig {return false}
    if lhs._exitCode != rhs._exitCode {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tensorboard_WorkerHeartbeatResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".WorkerHeartbeatResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "health_status"),
    2: .standard(proto: "worker_log"),
    3: .same(proto: "hostname"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularEnumField(value: &self.healthStatus) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.workerLog) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.hostname) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.healthStatus != .ok {
      try visitor.visitSingularEnumField(value: self.healthStatus, fieldNumber: 1)
    }
    if !self.workerLog.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.workerLog, fieldNumber: 2)
    }
    if !self.hostname.isEmpty {
      try visitor.visitSingularStringField(value: self.hostname, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tensorboard_WorkerHeartbeatResponse, rhs: Tensorboard_WorkerHeartbeatResponse) -> Bool {
    if lhs.healthStatus != rhs.healthStatus {return false}
    if lhs.workerLog != rhs.workerLog {return false}
    if lhs.hostname != rhs.hostname {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
