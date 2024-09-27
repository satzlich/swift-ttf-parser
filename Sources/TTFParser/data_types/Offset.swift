// Copyright 2024 satzlich

import Foundation

// MARK: - Offset

public struct Offset<T: BinaryInteger>: Equatable, Hashable {
    /// The semantic value.
    public let rawValue: T

    public init(_ rawValue: T) {
        self.rawValue = rawValue
    }

    /// rawValue == 0
    public var isNull: Bool {
        self.rawValue == 0
    }
}

/// 8-bit offset to a table, same as uint8, NULL offset = 0x00
public typealias Offset8 = Offset<UInt8>

/// Short offset to a table, same as uint16, NULL offset = 0x0000
public typealias Offset16 = Offset<UInt16>

// MARK: - Offset24

/// 24-bit offset to a table, same as uint24, NULL offset = 0x000000
public struct Offset24: Equatable, Hashable {
    /// The semantic value
    public let rawValue: UInt32

    public init(_ rawValue: UInt32) {
        precondition(rawValue <= 0xFFFFFF)
        self.rawValue = rawValue
    }

    /// rawValue == 0
    public var isNull: Bool {
        self.rawValue == 0
    }
}

/// Long offset to a table, same as uint32, NULL offset = 0x00000000
public typealias Offset32 = Offset<UInt32>

// MARK: - Offset + FixedDecodable

extension Offset: FixedDecodable where T: FixedDecodable {
    static var encodingWidth: Int { T.encodingWidth }

    static func decode(_ data: UnsafePointer<UInt8>) -> Offset {
        Offset(T.decode(data))
    }
}

// MARK: - Offset24 + FixedDecodable

extension Offset24: FixedDecodable {
    static var encodingWidth: Int { UInt24.encodingWidth }

    static func decode(_ data: UnsafePointer<UInt8>) -> Offset24 {
        Offset24(UInt24.decode(data).rawValue)
    }
}
