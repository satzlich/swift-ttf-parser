// Copyright 2024 satzlich

import Foundation

// MARK: - Offset24

/// 24-bit offset to a table, same as uint24, NULL offset = 0x000000
public struct Offset24: Equatable, Hashable {
    /// The semantic value embedded in UInt32
    public let rawValue: UInt32

    /// - Warning: Used only in ``Offset24.decode(_:)``.
    private init(_ rawValue: UInt32) {
        precondition(rawValue <= 0xFFFFFF)
        self.rawValue = rawValue
    }

    /// rawValue == 0
    public var isNull: Bool {
        self.rawValue == 0
    }
}

// MARK: - Offset24 + FixedDecodable

extension Offset24: FixedDecodable {
    static var encodingWidth: Int { UInt24.encodingWidth }

    static func decode(_ data: UnsafePointer<UInt8>) -> Offset24 {
        Offset24(UInt24.decode(data).rawValue)
    }
}
