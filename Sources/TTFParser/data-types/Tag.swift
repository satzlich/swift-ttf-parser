// Copyright 2024 Lie Yan

import TTFParserMacros

// MARK: - Tag

/**
 An array of four bytes, which is used to identify a table, design-variation axis,
 script, language system, feature, or baseline.

 # Specification
 A tag may assume any of the 2^32 states of four bytes,
 among which a subset are distinguished as **valid** and
 can be determined by method ``isValid()``.

 > Validity: Each byte within the array must have a value in the range 0x20 to 0x7E.
 It must have one to four non-space characters, padded with trailing
 spaces (byte value 0x20). A space character must not be followed by a
 non-space character.
 */
public struct Tag: Equatable, Hashable {
    /**
     Bytes of the tag.

     # Specification
     On little-endian platforms, the byte order is reversed.
     */
    public let rawValue: UInt32

    public init(_ rawValue: UInt32) {
        self.rawValue = rawValue
    }

    /// Returns `true` iff the tag is valid.
    public func isValid() -> Bool {
        TTFParserMacros.Tag.validate(self.rawValue)
    }
}

// MARK: - Tag + FixedDecodable

extension Tag: FixedDecodable {
    static var encodingWidth: Int { UInt32.encodingWidth }

    static func decode(_ data: UnsafePointer<UInt8>) -> Tag {
        Tag(UInt32.decode(data))
    }
}
