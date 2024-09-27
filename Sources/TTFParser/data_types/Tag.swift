// Copyright 2024 satzlich

import Foundation
import TTFParserMacros

// MARK: - Tag

/// Array of four uint8s (length = 32 bits) used to identify a table, design-variation
/// axis, script, language system, feature, or baseline.
struct Tag: Equatable, Hashable {
    /// The semantic value encoded in UInt32.
    /// ```
    /// rawValue = tag[0] * 2^24 + tag[1] * 2^16 + tag[2] * 2^8 + tag[3]
    /// ```
    let rawValue: UInt32

    init(_ rawValue: UInt32) {
        self.rawValue = rawValue
    }

    /// Returns true if the tag is valid in terms of syntax.
    func isValid() -> Bool {
        TTFParserMacros.isValidTag(self.rawValue)
    }
}

// MARK: - Tag + FixedDecodable

extension Tag: FixedDecodable {
    static var encodingWidth: Int { UInt32.encodingWidth }

    static func decode(_ data: UnsafePointer<UInt8>) -> Tag {
        Tag(UInt32.decode(data))
    }
}
