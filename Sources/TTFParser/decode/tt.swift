// Copyright 2024 satzlich

// MARK: - FixedDecodable

/// A type that is fixed-width and can be decoded from a pointer.
protocol FixedDecodable {
    static var encodingSize: Int { get }

    /// Decode a value from the given pointer.
    static func decode(_ data: UnsafePointer<UInt8>) -> Self
}

// MARK: - UInt8 + FixedDecodable

extension UInt8: FixedDecodable {
    static var encodingSize: Int { 1 }

    static func decode(_ data: UnsafePointer<UInt8>) -> UInt8 {
        return data.pointee
    }
}

// MARK: - Int8 + FixedDecodable

extension Int8: FixedDecodable {
    static var encodingSize: Int { 1 }

    static func decode(_ data: UnsafePointer<UInt8>) -> Int8 {
        return Int8(bitPattern: data.pointee)
    }
}

// MARK: - UInt16 + FixedDecodable

extension UInt16: FixedDecodable {
    static var encodingSize: Int { 2 }

    static func decode(_ data: UnsafePointer<UInt8>) -> UInt16 {
        UnsafeRawPointer(data)
            .loadUnaligned(as: UInt16.self)
            .bigEndian
    }
}

// MARK: - Int16 + FixedDecodable

extension Int16: FixedDecodable {
    static var encodingSize: Int { 2 }

    static func decode(_ data: UnsafePointer<UInt8>) -> Int16 {
        UnsafeRawPointer(data)
            .loadUnaligned(as: Int16.self)
            .bigEndian
    }
}

// MARK: - UInt24 + FixedDecodable

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

// MARK: - UInt32 + FixedDecodable

extension UInt32: FixedDecodable {
    static var encodingSize: Int { 4 }

    static func decode(_ data: UnsafePointer<UInt8>) -> UInt32 {
        UnsafeRawPointer(data)
            .loadUnaligned(as: UInt32.self)
            .bigEndian
    }
}

// MARK: - Int32 + FixedDecodable

extension Int32: FixedDecodable {
    static var encodingSize: Int { 4 }

    static func decode(_ data: UnsafePointer<UInt8>) -> Int32 {
        UnsafeRawPointer(data)
            .loadUnaligned(as: Int32.self)
            .bigEndian
    }
}

// MARK: - Offset + FixedDecodable

extension Offset where Self.Base: FixedDecodable {
    static var encodingSize: Int { Base.encodingSize }

    static func decode(_ data: UnsafePointer<UInt8>) -> Self {
        let value = Base.decode(data)
        return Self(value)
    }
}
