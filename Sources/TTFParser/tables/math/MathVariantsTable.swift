// Copyright 2024 Lie Yan

// MARK: - MathVariantsTable

struct MathVariantsTable: SafeDecodable {
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
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        self.minConnectorOverlap = UFWORD.decode(bytes.baseAddress! + Offsets.minConnectorOverlap)
        self.vertGlyphCoverageOffset = Offset16.decode(bytes.baseAddress! + Offsets.vertGlyphCoverageOffset)
        self.horizGlyphCoverageOffset = Offset16.decode(bytes.baseAddress! + Offsets.horizGlyphCoverageOffset)
        self.vertGlyphCount = UInt16.decode(bytes.baseAddress! + Offsets.vertGlyphCount)
        self.horizGlyphCount = UInt16.decode(bytes.baseAddress! + Offsets.horizGlyphCount)

        do {
            let bytes = bytes.rebase(Offsets.vertGlyphConstructionOffsets)
            let count = Int(self.vertGlyphCount)
            guard let vertGlyphConstructionOffsets = FlatArray<Offset16>(bytes, count) else {
                return nil
            }
            self.vertGlyphConstructionOffsets = vertGlyphConstructionOffsets
        }

        do {
            let bytes = bytes.rebase(Offsets.horizGlyphConstructionOffsets(Int(self.vertGlyphCount)))
            let count = Int(self.horizGlyphCount)
            guard let horizGlyphConstructionOffsets = FlatArray<Offset16>(bytes, count) else {
                return nil
            }
            self.horizGlyphConstructionOffsets = horizGlyphConstructionOffsets
        }

        self.bytes = bytes
    }

    static var minWidth: Int = Offsets.vertGlyphCoverageOffset

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathVariantsTable? {
        MathVariantsTable(bytes)
    }
}

extension MathVariantsTable {
    public var vertGlyphCoverage: CoverageTable? {
        self.vertGlyphCoverageOffset.offsetValue.flatMap {
            CoverageTable.decode(self.bytes.rebase($0))
        }
    }

    public var horizGlyphCoverage: CoverageTable? {
        self.horizGlyphCoverageOffset.offsetValue.flatMap {
            CoverageTable.decode(self.bytes.rebase($0))
        }
    }

    public var vertGlyphConstructions: OffsetArray16<MathGlyphConstructionTable> {
        self.vertGlyphConstructionOffsets.offsetArray(self.bytes)
    }

    public var horridGlyphConstructions: OffsetArray16<MathGlyphConstructionTable> {
        self.horizGlyphConstructionOffsets.offsetArray(self.bytes)
    }
}
