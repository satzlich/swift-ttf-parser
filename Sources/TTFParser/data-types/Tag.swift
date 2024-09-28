// Copyright 2024 Lie Yan

import Foundation
import TTFParserMacros

// MARK: - Tag

/// Array of four uint8s (length = 32 bits) used to identify a table, design-variation
/// axis, script, language system, feature, or baseline.
public struct Tag: Equatable, Hashable {
    /// The semantic value encoded in UInt32.
    /// ```
    /// rawValue = tag[0] * 2^24 + tag[1] * 2^16 + tag[2] * 2^8 + tag[3]
    /// ```
    public let rawValue: UInt32

    public init(_ rawValue: UInt32) {
        self.rawValue = rawValue
    }

    /// Returns true if the tag is valid in terms of syntax.
    ///
    /// - Note: Each byte within the array must have a value in the range 0x20 to 0x7E.
    /// It must have one to four non-space characters, padded with trailing
    /// spaces (byte value 0x20). A space character must not be followed by a
    /// non-space character.
    public func isValid() -> Bool {
        TTFParserMacros.Tag.isValidTag(self.rawValue)
    }
}

// MARK: - Tag + FixedDecodable

extension Tag: FixedDecodable {
    static var encodingWidth: Int { UInt32.encodingWidth }

    static func decode(_ data: UnsafePointer<UInt8>) -> Tag {
        Tag(UInt32.decode(data))
    }
}
