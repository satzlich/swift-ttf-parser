// Copyright 2024 satzlich

/// A type that is fixed-width and can be decoded from a pointer.
protocol FixedDecodable {
    static var encoding_size: Int { get }

    /// Decode a value from the given pointer.
    static func decode(_ data: UnsafePointer<UInt8>) -> Self
}

extension UInt8: FixedDecodable {
    static var encoding_size: Int { 1 }

    static func decode(_ data: UnsafePointer<UInt8>) -> UInt8 {
        return data.pointee
    }
}

extension Int8: FixedDecodable {
    static var encoding_size: Int { 1 }

    static func decode(_ data: UnsafePointer<UInt8>) -> Int8 {
        return Int8(bitPattern: UInt8.decode(data))
    }
}

extension UInt16: FixedDecodable {
    static var encoding_size: Int { 2 }

    static func decode(_ data: UnsafePointer<UInt8>) -> UInt16 {
        UnsafeRawPointer(data)
            .loadUnaligned(as: UInt16.self)
            .bigEndian
    }
}

extension Int16: FixedDecodable {
    static var encoding_size: Int { 2 }

    static func decode(_ data: UnsafePointer<UInt8>) -> Int16 {
        Int16(bitPattern: UInt16.decode(data))
    }
}

extension UInt24: FixedDecodable {
    static var encoding_size: Int { 3 }

    static func decode(_ data: UnsafePointer<UInt8>) -> UInt24 {
        let extended = [0, data[0], data[1], data[2]]
        let value = extended.withUnsafeBytes {
            $0.load(as: UInt32.self).bigEndian
        }
        return UInt24(value)
    }
}

extension UInt32: FixedDecodable {
    static var encoding_size: Int { 4 }

    static func decode(_ data: UnsafePointer<UInt8>) -> UInt32 {
        UnsafeRawPointer(data)
            .loadUnaligned(as: UInt32.self)
            .bigEndian
    }
}

extension Int32: FixedDecodable {
    static var encoding_size: Int { 4 }

    static func decode(_ data: UnsafePointer<UInt8>) -> Int32 {
        Int32(bitPattern: UInt32.decode(data))
    }
}

extension UInt64: FixedDecodable {
    static var encoding_size: Int { 8 }

    static func decode(_ data: UnsafePointer<UInt8>) -> UInt64 {
        UnsafeRawPointer(data)
            .loadUnaligned(as: UInt64.self)
            .bigEndian
    }
}

extension Int64: FixedDecodable {
    static var encoding_size: Int { 8 }

    static func decode(_ data: UnsafePointer<UInt8>) -> Int64 {
        Int64(bitPattern: UInt64.decode(data))
    }
}

extension LONGDATETIME: FixedDecodable {
    static var encoding_size: Int { Base.encoding_size }

    static func decode(_ data: UnsafePointer<UInt8>) -> LONGDATETIME {
        LONGDATETIME(Base.decode(data))
    }
}

extension Tag: FixedDecodable {
    static var encoding_size: Int { Base.encoding_size }

    static func decode(_ data: UnsafePointer<UInt8>) -> Tag {
        Tag(Base.decode(data))
    }
}

extension Offset: FixedDecodable where Base: FixedDecodable {
    static var encoding_size: Int { Base.encoding_size }

    static func decode(_ data: UnsafePointer<UInt8>) -> Offset<Base, RawValue> {
        Offset(Base.decode(data))
    }
}

extension Version16Dot16: FixedDecodable {
    static var encoding_size: Int { Base.encoding_size }

    static func decode(_ data: UnsafePointer<UInt8>) -> Version16Dot16 {
        Version16Dot16(Base.decode(data))
    }
}
