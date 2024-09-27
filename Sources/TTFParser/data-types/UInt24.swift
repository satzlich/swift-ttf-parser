// Copyright 2024 satzlich

import Foundation

// MARK: - UInt24

/// 24-bit unsigned integer.
///
/// - Note: No companion Int24 struct, since it's not needed.
public struct UInt24: Equatable, Hashable {
    /// The semantic value embedded in UInt32
    public let rawValue: UInt32

    /// - Warning: Used only in ``UInt24.decode(_:)``.
    private init(_ rawValue: UInt32) {
        precondition(rawValue <= 0xFFFFFF)
        self.rawValue = rawValue
    }
}

// MARK: - UInt24 + FixedDecodable

extension UInt24: FixedDecodable {
    static var encodingWidth: Int { 3 }

    static func decode(_ data: UnsafePointer<UInt8>) -> UInt24 {
        let extended = [0, data[0], data[1], data[2]]
        let value = extended.withUnsafeBytes {
            $0.load(as: UInt32.self).bigEndian
        }
        return UInt24(value)
    }
}
