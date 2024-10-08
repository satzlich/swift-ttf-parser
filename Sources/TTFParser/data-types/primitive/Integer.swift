// Copyright 2024 Lie Yan

// MARK: - UInt8 + FixedDecodable

extension UInt8: FixedDecodable {
    public static var encodingWidth: Int { 1 }

    public static func decode(_ bytes: UnsafePointer<UInt8>) -> UInt8 {
        return bytes.pointee
    }
}

// MARK: - Int8 + FixedDecodable

extension Int8: FixedDecodable {
    public static var encodingWidth: Int { 1 }

    public static func decode(_ bytes: UnsafePointer<UInt8>) -> Int8 {
        return Int8(bitPattern: UInt8.decode(bytes))
    }
}

// MARK: - UInt16 + FixedDecodable

extension UInt16: FixedDecodable {
    public static var encodingWidth: Int { 2 }

    public static func decode(_ bytes: UnsafePointer<UInt8>) -> UInt16 {
        UnsafeRawPointer(bytes)
            .loadUnaligned(as: UInt16.self)
            .bigEndian
    }
}

// MARK: - Int16 + FixedDecodable

extension Int16: FixedDecodable {
    public static var encodingWidth: Int { 2 }

    public static func decode(_ bytes: UnsafePointer<UInt8>) -> Int16 {
        Int16(bitPattern: UInt16.decode(bytes))
    }
}

// MARK: - UInt32 + FixedDecodable

extension UInt32: FixedDecodable {
    public static var encodingWidth: Int { 4 }

    public static func decode(_ bytes: UnsafePointer<UInt8>) -> UInt32 {
        UnsafeRawPointer(bytes)
            .loadUnaligned(as: UInt32.self)
            .bigEndian
    }
}

// MARK: - Int32 + FixedDecodable

extension Int32: FixedDecodable {
    public static var encodingWidth: Int { 4 }

    public static func decode(_ bytes: UnsafePointer<UInt8>) -> Int32 {
        Int32(bitPattern: UInt32.decode(bytes))
    }
}

// MARK: - Int64 + FixedDecodable

extension Int64: FixedDecodable {
    public static var encodingWidth: Int { 8 }

    public static func decode(_ bytes: UnsafePointer<UInt8>) -> Int64 {
        UnsafeRawPointer(bytes)
            .loadUnaligned(as: Int64.self)
            .bigEndian
    }
}
