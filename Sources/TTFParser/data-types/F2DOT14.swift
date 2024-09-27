// Copyright 2024 satzlich

import Foundation

// MARK: - F2DOT14

/// 16-bit signed fixed number with the low 14 bits of fraction (2.14).
public struct F2DOT14: Equatable, Hashable {
    /// The semantic value scaled up by 16384
    public let rawValue: Int16

    public init(_ rawValue: Int16) {
        self.rawValue = rawValue
    }

    public var floatValue: Float {
        Float(self.rawValue) / 16384
    }
}

// MARK: - F2DOT14 + FixedDecodable

extension F2DOT14: FixedDecodable {
    static var encodingWidth: Int { Int16.encodingWidth }

    static func decode(_ data: UnsafePointer<UInt8>) -> F2DOT14 {
        F2DOT14(Int16.decode(data))
    }
}
