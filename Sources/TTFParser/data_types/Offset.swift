// Copyright 2024 satzlich

import Foundation

// MARK: - Offset

struct Offset<T: BinaryInteger> {
    /// The semantic value.
    let rawValue: T

    init(_ rawValue: T) {
        self.rawValue = rawValue
    }

    var isNull: Bool {
        self.rawValue == 0
    }
}

/// 8-bit offset to a table, same as uint8, NULL offset = 0x00
typealias Offset8 = Offset<UInt8>

/// Short offset to a table, same as uint16, NULL offset = 0x0000
typealias Offset16 = Offset<UInt16>

// MARK: - Offset24

/// 24-bit offset to a table, same as uint24, NULL offset = 0x000000
struct Offset24 {
    /// The semantic value
    let rawValue: UInt32

    init(_ rawValue: UInt32) {
        precondition(rawValue <= 0xFFFFFF)
        self.rawValue = rawValue
    }

    /// rawValue == 0
    var isNull: Bool {
        self.rawValue == 0
    }
}

/// Long offset to a table, same as uint32, NULL offset = 0x00000000
typealias Offset32 = Offset<UInt32>

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
