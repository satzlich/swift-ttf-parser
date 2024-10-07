// Copyright 2024 Lie Yan

// MARK: - GlyphPartRecord

public struct GlyphPartRecord: FixedDecodable {
    /// Glyph ID for the part.
    public let glyphID: UInt16

    /// Advance width/ height, in design units, of the straight bar connector
    /// material at the start of the glyph in the direction of the extension (the
    /// left end for horizontal extension, the bottom end for vertical extension).
    public let startConnectorLength: UFWORD

    /// Advance width/ height, in design units, of the straight bar connector
    /// material at the end of the glyph in the direction of the extension (the right
    /// end for horizontal extension, the top end for vertical extension).
    public let endConnectorLength: UFWORD

    /// Full advance width/height for this part in the direction of the extension, in
    /// design units.
    public let fullAdvance: UFWORD

    /**
     Part qualifiers. PartFlags enumeration currently uses only one bit:

     | Hex Value | Description                                  |
     |-----------|----------------------------------------------|
     | 0x0001    | EXTENDER_FLAG: If set, the part can be skipped or repeated. |
     | 0xFFFE    | Reserved.                                   |
     */
    private let partFlags: UInt16

    private enum Offsets {
        static let glyphID = 0
        static let startConnectorLength = glyphID + UInt16.encodingWidth
        static let endConnectorLength = startConnectorLength + UFWORD.encodingWidth
        static let fullAdvance = endConnectorLength + UFWORD.encodingWidth
        static let partFlags = fullAdvance + UFWORD.encodingWidth
    }

    private init(_ bytes: UnsafePointer<UInt8>) {
        self.glyphID = UInt16.decode(bytes + Offsets.glyphID)
        self.startConnectorLength = UFWORD.decode(bytes + Offsets.startConnectorLength)
        self.endConnectorLength = UFWORD.decode(bytes + Offsets.endConnectorLength)
        self.fullAdvance = UFWORD.decode(bytes + Offsets.fullAdvance)
        self.partFlags = UInt16.decode(bytes + Offsets.partFlags)
    }

    public static var encodingWidth: Int = Offsets.partFlags + UInt16.encodingWidth

    public static func decode(_ bytes: UnsafePointer<UInt8>) -> GlyphPartRecord {
        GlyphPartRecord(bytes)
    }
}

extension GlyphPartRecord {
    public func isExtender() -> Bool {
        partFlags & PartFlagMark.EXTENDER_FLAG != 0
    }
}

// MARK: - PartFlagMark

enum PartFlagMark {
    public static let EXTENDER_FLAG: UInt16 = 0x0001
    private static let Reserved: UInt16 = 0xFFFE
}
