// Copyright 2024 Lie Yan

// MARK: - MathGlyphInfoTable

struct MathGlyphInfoTable: SafeDecodable {
    /**
     Offset to MathItalicsCorrectionInfo table, from the beginning of the MathGlyphInfo table.
     */
    public let mathItalicsCorrectionInfoOffset: Offset16

    /**
     Offset to MathTopAccentAttachment table, from the beginning of the MathGlyphInfo table.
     */
    public let mathTopAccentAttachmentOffset: Offset16

    /**
     Offset to ExtendedShapes coverage table, from the beginning of the MathGlyphInfo table.
     When the glyph to the left or right of a box is an extended shape variant, the (ink)
     box should be used for vertical positioning purposes, not the default position
     defined by values in MathConstants table. May be NULL.
     */
    public let extendedShapeCoverageOffset: Offset16

    /**
     Offset to MathKernInfo table, from the beginning of the MathGlyphInfo table.
     */
    public let mathKernInfoOffset: Offset16

    private enum Offsets {
        static let mathItalicsCorrectionInfoOffset = 0
        static let mathTopAccentAttachmentOffset = mathItalicsCorrectionInfoOffset + Offset16.encodingWidth
        static let extendedShapeCoverageOffset = mathTopAccentAttachmentOffset + Offset16.encodingWidth
        static let mathKernInfoOffset = extendedShapeCoverageOffset + Offset16.encodingWidth
    }

    private let bytes: UnsafeBufferPointer<UInt8>

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        self.mathItalicsCorrectionInfoOffset = .decode(bytes.baseAddress! + Offsets.mathItalicsCorrectionInfoOffset)
        self.mathTopAccentAttachmentOffset = .decode(bytes.baseAddress! + Offsets.mathTopAccentAttachmentOffset)
        self.extendedShapeCoverageOffset = .decode(bytes.baseAddress! + Offsets.extendedShapeCoverageOffset)
        self.mathKernInfoOffset = .decode(bytes.baseAddress! + Offsets.mathKernInfoOffset)

        self.bytes = bytes
    }

    static let minWidth: Int = Offsets.mathKernInfoOffset + Offset16.encodingWidth

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathGlyphInfoTable? {
        MathGlyphInfoTable(bytes)
    }
}

extension MathGlyphInfoTable {
    public var italicsCorrectionInfo: MathItalicsCorrectionInfoTable? {
        self.mathItalicsCorrectionInfoOffset.lift(bytes)
    }

    public var topAccentAttachment: MathTopAccentAttachmentTable? {
        self.mathTopAccentAttachmentOffset.lift(bytes)
    }

    public var extendedShapeCoverage: CoverageTable? {
        self.extendedShapeCoverageOffset.lift(bytes)
    }

    public var kernInfo: MathKernInfoTable? {
        self.mathKernInfoOffset.lift(bytes)
    }
}
