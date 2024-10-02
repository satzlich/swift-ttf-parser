// Copyright 2024 Lie Yan

// MARK: - Offset24

/// 24-bit offset to a table, same as uint24, NULL offset = 0x000000
public struct Offset24: Equatable, Hashable {
    public let offsetValue: Int?

    public init(_ rawValue: UInt24) {
        self.offsetValue =
            if rawValue == 0 {
                nil
            }
            else {
                rawValue.intValue
            }
    }
}

// MARK: - Offset24 + OffsetProtocol

extension Offset24: OffsetProtocol {
    typealias RawValue = UInt32
}

// MARK: - Offset24 + FixedDecodable

extension Offset24: FixedDecodable {
    static var encodingWidth: Int { UInt24.encodingWidth }

    @usableFromInline
    static func decode(_ data: UnsafePointer<UInt8>) -> Offset24 {
        Offset24(UInt24.decode(data))
    }
}
