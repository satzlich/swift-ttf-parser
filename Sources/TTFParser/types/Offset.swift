// Copyright 2024 Lie Yan

// MARK: - Offset

public struct Offset<T: BinaryInteger>: Equatable, Hashable {
    /// The semantic value.
    private let rawValue: T

    private init(_ rawValue: T) {
        self.rawValue = rawValue
    }

    public var isNull: Bool {
        self.rawValue == 0
    }

    public func apply<R>(_ f: (Int) -> R) -> R? {
        if self.isNull {
            return nil
        }
        else {
            return f(Int(self.rawValue))
        }
    }

    public func apply<R>(_ f: (Int) -> R?) -> R? {
        if self.isNull {
            return nil
        }
        else {
            return f(Int(self.rawValue))
        }
    }
}

// MARK: - Offset + OffsetProtocol

extension Offset: OffsetProtocol {
    typealias RawValue = T
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
