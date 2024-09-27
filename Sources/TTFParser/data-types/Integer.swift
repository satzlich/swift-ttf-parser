// Copyright 2024 satzlich

import Foundation

// MARK: - UInt8 + FixedDecodable

extension UInt8: FixedDecodable {
    static var encodingWidth: Int { 1 }

    static func decode(_ data: UnsafePointer<UInt8>) -> UInt8 {
        return data.pointee
    }
}

// MARK: - Int8 + FixedDecodable

extension Int8: FixedDecodable {
    static var encodingWidth: Int { 1 }

    static func decode(_ data: UnsafePointer<UInt8>) -> Int8 {
        return Int8(bitPattern: UInt8.decode(data))
    }
}

// MARK: - UInt16 + FixedDecodable

extension UInt16: FixedDecodable {
    static var encodingWidth: Int { 2 }

    static func decode(_ data: UnsafePointer<UInt8>) -> UInt16 {
        UnsafeRawPointer(data)
            .loadUnaligned(as: UInt16.self)
            .bigEndian
    }
}

// MARK: - Int16 + FixedDecodable

extension Int16: FixedDecodable {
    static var encodingWidth: Int { 2 }

    static func decode(_ data: UnsafePointer<UInt8>) -> Int16 {
        Int16(bitPattern: UInt16.decode(data))
    }
}

// MARK: - UInt32 + FixedDecodable

extension UInt32: FixedDecodable {
    static var encodingWidth: Int { 4 }

    static func decode(_ data: UnsafePointer<UInt8>) -> UInt32 {
        UnsafeRawPointer(data)
            .loadUnaligned(as: UInt32.self)
            .bigEndian
    }
}

// MARK: - Int32 + FixedDecodable

extension Int32: FixedDecodable {
    static var encodingWidth: Int { 4 }

    static func decode(_ data: UnsafePointer<UInt8>) -> Int32 {
        Int32(bitPattern: UInt32.decode(data))
    }
}

// MARK: - UInt64 + FixedDecodable

extension UInt64: FixedDecodable {
    static var encodingWidth: Int { 8 }

    static func decode(_ data: UnsafePointer<UInt8>) -> UInt64 {
        UnsafeRawPointer(data)
            .loadUnaligned(as: UInt64.self)
            .bigEndian
    }
}

// MARK: - Int64 + FixedDecodable

extension Int64: FixedDecodable {
    static var encodingWidth: Int { 8 }

    static func decode(_ data: UnsafePointer<UInt8>) -> Int64 {
        Int64(bitPattern: UInt64.decode(data))
    }
}
