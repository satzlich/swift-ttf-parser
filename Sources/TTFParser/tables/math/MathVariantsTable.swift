// Copyright 2024 Lie Yan

struct MathVariantsTable: LinkedDecodable {
    /**
     Minimum overlap of connecting glyphs during glyph construction, in design units.
     */
    public let minConnectorOverlap: UFWORD

    /**
     Offset to Coverage table, from the beginning of the MathVariants table.
     */
    public let vertGlyphCoverageOffset: Offset16

    /**
     Offset to Coverage table, from the beginning of the MathVariants table.
     */
    public let horizGlyphCoverageOffset: Offset16

    /**
     Number of glyphs for which information is provided for vertically growing variants.
     Must be the same as the number of glyph IDs referenced in the vertical Coverage table.
     */
    public let vertGlyphCount: UInt16

    /**
     Number of glyphs for which information is provided for horizontally growing variants.
     Must be the same as the number of glyph IDs referenced in the horizontal Coverage table.
     */
    public let horizGlyphCount: UInt16

    /**
     Array of offsets to MathGlyphConstruction tables, from the beginning of the
     MathVariants table, for shapes growing in the vertical direction.
     */
    public let vertGlyphConstructionOffsets: FlatArray<Offset16>

    /**
     Array of offsets to MathGlyphConstruction tables, from the beginning of
     the MathVariants table, for shapes growing in the horizontal direction.
     */
    public let horizGlyphConstructionOffsets: FlatArray<Offset16>

    

    private enum Offsets {
        static let minConnectorOverlap = 0
        static let vertGlyphCoverageOffset = minConnectorOverlap + UFWORD.encodingWidth
        static let horizGlyphCoverageOffset = vertGlyphCoverageOffset + Offset16.encodingWidth
        static let vertGlyphCount = horizGlyphCoverageOffset + Offset16.encodingWidth
        static let horizGlyphCount = vertGlyphCount + UInt16.encodingWidth
        static let vertGlyphConstructionOffsets = horizGlyphCount + UInt16.encodingWidth
        static func horizGlyphConstructionOffsets(_ vertGlyphCount: Int) -> Int {
            self.vertGlyphConstructionOffsets + Offset16.encodingWidth * vertGlyphCount
        }
    }

    private let bytes: UnsafeBufferPointer<UInt8>

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.leastWidth else {
            return nil
        }

        let baseAddress = bytes.baseAddress!

        self.minConnectorOverlap = UFWORD.decode(baseAddress + Offsets.minConnectorOverlap)
        self.vertGlyphCoverageOffset = Offset16.decode(baseAddress + Offsets.vertGlyphCoverageOffset)
        self.horizGlyphCoverageOffset = Offset16.decode(baseAddress + Offsets.horizGlyphCoverageOffset)
        self.vertGlyphCount = UInt16.decode(baseAddress + Offsets.vertGlyphCount)
        self.horizGlyphCount = UInt16.decode(baseAddress + Offsets.horizGlyphCount)

        guard let vertGlyphConstructionOffsets =
            FlatArray<Offset16>(
                bytes.rebase(Offsets.vertGlyphConstructionOffsets),
                Int(self.vertGlyphCount)
            )
        else {
            return nil
        }

        guard let horizGlyphConstructionOffsets =
            FlatArray<Offset16>(
                bytes.rebase(Offsets.horizGlyphConstructionOffsets(Int(self.vertGlyphCount))),
                Int(self.horizGlyphCount)
            )
        else {
            return nil
        }

        self.vertGlyphConstructionOffsets = vertGlyphConstructionOffsets
        self.horizGlyphConstructionOffsets = horizGlyphConstructionOffsets

        self.bytes = bytes
    }

    

    static var leastWidth: Int = Offsets.vertGlyphCoverageOffset

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathVariantsTable? {
        MathVariantsTable(bytes)
    }
}
