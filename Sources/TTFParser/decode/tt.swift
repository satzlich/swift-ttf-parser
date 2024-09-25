// Copyright 2024 satzlich

/// A type that is fixed-width and can be decoded from a pointer.
protocol FixedDecodable {
    static var encodingSize: Int { get }

    /// Decode a value from the given pointer.
    static func decode(_ data: UnsafePointer<UInt8>) -> Self
}

extension UInt8: FixedDecodable {
    static var encodingSize: Int { 1 }

    static func decode(_ data: UnsafePointer<UInt8>) -> UInt8 {
        return data.pointee
    }
}

extension Int8: FixedDecodable {
    static var encodingSize: Int { 1 }

    static func decode(_ data: UnsafePointer<UInt8>) -> Int8 {
        return Int8(bitPattern: data.pointee)
    }
}

extension UInt16: FixedDecodable {
    static var encodingSize: Int { 2 }

    static func decode(_ data: UnsafePointer<UInt8>) -> UInt16 {
        UnsafeRawPointer(data)
            .loadUnaligned(as: UInt16.self)
            .bigEndian
    }
}

extension Int16: FixedDecodable {
    static var encodingSize: Int { 2 }

    static func decode(_ data: UnsafePointer<UInt8>) -> Int16 {
        UnsafeRawPointer(data)
            .loadUnaligned(as: Int16.self)
            .bigEndian
    }
}

extension UInt24: FixedDecodable {
    static var encodingSize: Int { 3 }

    static func decode(_ data: UnsafePointer<UInt8>) -> UInt24 {
        let extended = [0, data[0], data[1], data[2]]
        let value = extended.withUnsafeBytes {
            $0.load(as: UInt32.self).bigEndian
        }
        return UInt24(value)
    }
}

extension UInt32: FixedDecodable {
    static var encodingSize: Int { 4 }

    static func decode(_ data: UnsafePointer<UInt8>) -> UInt32 {
        UnsafeRawPointer(data)
            .loadUnaligned(as: UInt32.self)
            .bigEndian
    }
}

extension Int32: FixedDecodable {
    static var encodingSize: Int { 4 }

    static func decode(_ data: UnsafePointer<UInt8>) -> Int32 {
        UnsafeRawPointer(data)
            .loadUnaligned(as: Int32.self)
            .bigEndian
    }
}

extension Offset: FixedDecodable where Base: FixedDecodable {
    static var encodingSize: Int { Base.encodingSize }

    static func decode(_ data: UnsafePointer<UInt8>) -> Offset<Base, RawValue> {
        Offset(Base.decode(data))
    }
}
