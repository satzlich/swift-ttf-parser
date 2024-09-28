// Copyright 2024 Lie Yan

// MARK: - FixedDecodable

/**
 A type that uses fixed-width encoding.

 - Warning: Internal use only.
 */
protocol FixedDecodable {
    /**
     Number of bytes used to encode the value.
     */
    static var encodingWidth: Int { get }

    /**
     Reconstructs a value from the first ``encodingWidth`` bytes.
     
     - Parameter bytes: The bytes to read from
     
     - Returns: The reconstructed value

     - Note: Only bit pattern reconstruction is carried out; **no validation**
     over the semantic value.
     */
    static func decode(_ bytes: UnsafePointer<UInt8>) -> Self
}
