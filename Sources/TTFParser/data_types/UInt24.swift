// Copyright 2024 satzlich

import Foundation

// MARK: - UInt24

/// 24-bit unsigned integer.
///
/// - Note: No companion Int24 struct, since it's not needed.
struct UInt24: Equatable, Comparable, Hashable {
    /// The semantic value embedding in UInt32
    let rawValue: UInt32

    init(_ rawValue: UInt32) {
        precondition(rawValue <= 0xFFFFFF)
        self.rawValue = rawValue
    }

    static func < (lhs: UInt24, rhs: UInt24) -> Bool {
        lhs.rawValue < rhs.rawValue
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
