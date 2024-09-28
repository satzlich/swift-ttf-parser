// Copyright 2024 Lie Yan

// MARK: - Offset24

/// 24-bit offset to a table, same as uint24, NULL offset = 0x000000
public struct Offset24: Equatable, Hashable {
    /// The semantic value embedded in UInt32
    public let rawValue: UInt32

    /// - Warning: Used in ``Offset24.decode(_:)`` only.
    private init(_ rawValue: UInt32) {
        precondition(rawValue <= 0xFFFFFF)
        self.rawValue = rawValue
    }

    /// True iff the offset is null, i.e. 0
    public var isNull: Bool {
        self.rawValue == 0
    }
}

// MARK: - Offset24 + FixedDecodable

extension Offset24: FixedDecodable {
    static var encodingWidth: Int { UInt24.encodingWidth }

    @usableFromInline
    static func decode(_ data: UnsafePointer<UInt8>) -> Offset24 {
        Offset24(UInt24.decode(data).rawValue)
    }
}
