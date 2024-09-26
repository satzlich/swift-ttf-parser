// Copyright 2024 Lie Yan

// MARK: - MathVariantsTable

public struct MathVariantsTable: SafeDecodable {
    /**
     Minimum overlap of connecting glyphs during glyph construction, in design units.
     */
    public let minConnectorOverlap: UFWORD

    public var verticalConstructions: CoverageArray<OffsetArray16<MathGlyphConstructionTable>>?

    public var horizontalConstructions: CoverageArray<OffsetArray16<MathGlyphConstructionTable>>?

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

        let vertGlyphCount = UInt16.decode(bytes.baseAddress! + Offsets.vertGlyphCount)
        let horizGlyphCount = UInt16.decode(bytes.baseAddress! + Offsets.horizGlyphCount)

        func make(_ coverageOffset: Int, _ glyphCount: UInt16, _ constructionOffsets: Int)
        -> CoverageArray<OffsetArray16<MathGlyphConstructionTable>>? {
            let coverageOffset = Offset16.decode(bytes.baseAddress! + coverageOffset)
            let constructionOffsets = bytes.rebase(constructionOffsets)

            guard let coverage: CoverageTable = coverageOffset.lift(bytes)
            else {
                return nil
            }

            guard let constructionOffsets = FlatArray<Offset16>(constructionOffsets, Int(glyphCount))
            else {
                return nil
            }

            let offsetArray: OffsetArray16<MathGlyphConstructionTable>
                = constructionOffsets.offsetArray(bytes)

            return CoverageArray(offsetArray, coverage)
        }

        self.horizontalConstructions = make(
            Offsets.horizGlyphCoverageOffset,
            horizGlyphCount,
            Offsets.horizGlyphConstructionOffsets(Int(vertGlyphCount))
        )

        self.verticalConstructions = make(
            Offsets.vertGlyphCoverageOffset,
            vertGlyphCount,
            Offsets.vertGlyphConstructionOffsets
        )

        self.bytes = bytes
    }

    public static let minWidth: Int = Offsets.vertGlyphCoverageOffset

    public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathVariantsTable? {
        MathVariantsTable(bytes)
    }
}
