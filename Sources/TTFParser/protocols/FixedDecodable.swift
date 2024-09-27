// Copyright 2024 satzlich

// MARK: - FixedDecodable

/// A type that uses fixed-width encoding and can be decoded from arbitrary bit
/// patterns.
protocol FixedDecodable {
    /// The number of bytes used to encode the value.
    static var encodingWidth: Int { get }

    /// Decode a value from the given pointer.
    static func decode(_ data: UnsafePointer<UInt8>) -> Self
}
