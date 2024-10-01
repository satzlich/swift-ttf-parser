// Copyright 2024 Lie Yan

// MARK: - Offset

public struct Offset<T: BinaryInteger>: Equatable, Hashable {
    public let offsetValue: Int?

    public init(_ rawValue: T) {
        self.offsetValue =
            if rawValue == 0 {
                nil
            }
            else {
                Int(rawValue)
            }
    }
}

// MARK: - Offset + OffsetProtocol

extension Offset: OffsetProtocol {
}

// MARK: - Offset + FixedDecodable

extension Offset: FixedDecodable where T: FixedDecodable {
    @usableFromInline
    static var encodingWidth: Int { T.encodingWidth }

    @usableFromInline
    static func decode(_ data: UnsafePointer<UInt8>) -> Offset {
        Offset(T.decode(data))
    }
}

// MARK: - Specialized Offset Types

/// 8-bit offset to a table, same as uint8, NULL offset = 0x00
public typealias Offset8 = Offset<UInt8>

/// Short offset to a table, same as uint16, NULL offset = 0x0000
public typealias Offset16 = Offset<UInt16>

/// Long offset to a table, same as uint32, NULL offset = 0x00000000
public typealias Offset32 = Offset<UInt32>
