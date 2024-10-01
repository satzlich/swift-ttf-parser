// Copyright 2024 Lie Yan

// MARK: - LONGDATETIME

/// Date and time represented in number of seconds since 12:00 midnight, January
/// 1, 1904, UTC. The value is represented as a signed 64-bit integer.
public struct LONGDATETIME: Equatable, Hashable {
    /// The semantic value encoded in Int64
    private let rawValue: Int64

    public init(_ rawValue: Int64) {
        self.rawValue = rawValue
    }
}

// MARK: - LONGDATETIME + FixedDecodable

extension LONGDATETIME: FixedDecodable {
    static var encodingWidth: Int { Int64.encodingWidth }

    static func decode(_ data: UnsafePointer<UInt8>) -> LONGDATETIME {
        LONGDATETIME(Int64.decode(data))
    }
}
