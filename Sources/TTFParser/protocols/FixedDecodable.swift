// Copyright 2024 satzlich

// MARK: - FixedDecodable

/// A type that uses fixed-width encoding.
///
/// - Warning: Internal use only.
protocol FixedDecodable {
    /// The number of bytes used to encode the value.
    static var encodingWidth: Int { get }

    /// Reconstruct the binary representation from the bytes in `data`.
    ///
    /// Validation over the semantic value is not performed.
    static func decode(_ data: UnsafePointer<UInt8>) -> Self
}
