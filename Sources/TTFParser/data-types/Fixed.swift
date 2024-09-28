// Copyright 2024 Lie Yan

// MARK: - Fixed

/// 32-bit signed fixed-point number (16.16)
public struct Fixed: Equatable, Hashable {
    /// The semantic value scaled up by 65536
    public let rawValue: Int32

    public init(_ rawValue: Int32) {
        self.rawValue = rawValue
    }

    /// The semantic value in float
    public var floatValue: Float {
        Float(self.rawValue) / 65536
    }
}

// MARK: - Fixed + FixedDecodable

extension Fixed: FixedDecodable {
    static var encodingWidth: Int { Int32.encodingWidth }

    static func decode(_ bytes: UnsafePointer<UInt8>) -> Fixed {
        Fixed(Int32.decode(bytes))
    }
}
