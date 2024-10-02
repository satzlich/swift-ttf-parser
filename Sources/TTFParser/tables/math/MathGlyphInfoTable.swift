// Copyright 2024 Lie Yan

struct MathGlyphInfoTable: LinkedDecodable {
    // MARK: -  Properties

    /**
     Offset to MathItalicsCorrectionInfo table, from the beginning of the MathGlyphInfo table.
     */
    private let mathItalicsCorrectionInfoOffset: Offset16

    public private(set) lazy var mathItalicsCorrectionInfo: MathItalicsCorrectionInfoTable? = {
        guard let offsetValue = mathItalicsCorrectionInfoOffset.offsetValue else {
            return nil
        }
        return MathItalicsCorrectionInfoTable.decode(self.bytes.rebase(offsetValue))
    }()

    /**
     Offset to MathTopAccentAttachment table, from the beginning of the MathGlyphInfo table.
     */
    private let mathTopAccentAttachmentOffset: Offset16

    public private(set) lazy var mathTopAccentAttachment: MathTopAccentAttachmentTable? = {
        guard let offsetValue = mathTopAccentAttachmentOffset.offsetValue else {
            return nil
        }
        return MathTopAccentAttachmentTable.decode(self.bytes.rebase(offsetValue))
    }()

    /**
     Offset to ExtendedShapes coverage table, from the beginning of the MathGlyphInfo table.
     When the glyph to the left or right of a box is an extended shape variant, the (ink)
     box should be used for vertical positioning purposes, not the default position
     defined by values in MathConstants table.

     May be NULL.
     */
    private let extendedShapeCoverageOffset: Offset16

    public private(set) lazy var extendedShapeCoverage: ExtendedShapeCoverageTable? = {
        guard let offsetValue = extendedShapeCoverageOffset.offsetValue else {
            return nil
        }
        return ExtendedShapeCoverageTable.decode(self.bytes.rebase(offsetValue))
    }()

    /**
     Offset to MathKernInfo table, from the beginning of the MathGlyphInfo table.
     */
    public let mathKernInfoOffset: Offset16

    public private(set) lazy var mathKernInfo: MathKernInfoTable? = {
        guard let offsetValue = mathKernInfoOffset.offsetValue else {
            return nil
        }
        return MathKernInfoTable.decode(self.bytes.rebase(offsetValue))
    }()

    // MARK: - Offsets

    private enum Offsets {
        static let mathItalicsCorrectionInfoOffset = 0
        static let mathTopAccentAttachmentOffset = mathItalicsCorrectionInfoOffset + Offset16.encodingWidth
        static let extendedShapeCoverageOffset = mathTopAccentAttachmentOffset + Offset16.encodingWidth
        static let mathKernInfoOffset = extendedShapeCoverageOffset + Offset16.encodingWidth
    }

    private let bytes: UnsafeBufferPointer<UInt8>

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.leastWidth else {
            return nil
        }

        let baseAddress = bytes.baseAddress!

        self.mathItalicsCorrectionInfoOffset = Offset16.decode(baseAddress + Offsets.mathItalicsCorrectionInfoOffset)
        self.mathTopAccentAttachmentOffset = Offset16.decode(baseAddress + Offsets.mathTopAccentAttachmentOffset)
        self.extendedShapeCoverageOffset = Offset16.decode(baseAddress + Offsets.extendedShapeCoverageOffset)
        self.mathKernInfoOffset = Offset16.decode(baseAddress + Offsets.mathKernInfoOffset)

        self.bytes = bytes
    }

    static var leastWidth: Int = Offsets.mathKernInfoOffset + Offset16.encodingWidth

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathGlyphInfoTable? {
        MathGlyphInfoTable(bytes)
    }
}
