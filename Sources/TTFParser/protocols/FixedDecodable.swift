// Copyright 2024 Lie Yan

// MARK: - FixedDecodable

/**
 A type that uses fixed-width encoding.

 - Warning: Internal use only.
 */
public protocol FixedDecodable {
    /**
     Number of bytes used to encode the value.
     */
    static var encodingWidth: Int { get }

    /**
     Reconstructs a value from bytes.

     - Parameter bytes: The bytes to read from

     - Returns: The reconstructed value
     */
    static func decode(_ bytes: UnsafePointer<UInt8>) -> Self
}
