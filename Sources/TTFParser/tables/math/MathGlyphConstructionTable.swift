// Copyright 2024 Lie Yan

struct MathGlyphConstructionTable: SafeDecodable {
    /**
     Offset to the GlyphAssembly table for this shape, from the beginning of
     the MathGlyphConstruction table. May be NULL.
     */
    public let glyphAssemblyOffset: Offset16

    /**
     Count of glyph growing variants for this glyph.
     */
    public let variantCount: UInt16

    /**
     MathGlyphVariantRecords for alternative variants of the glyphs.
     Array length given by variantCount.
     */
    public let mathGlyphVariantRecords: FlatArray<MathGlyphVariantRecord>

    private enum Offsets {
        static let glyphAssemblyOffset = 0
        static let variantCount = glyphAssemblyOffset + Offset16.encodingWidth
        static let mathGlyphVariantRecords = variantCount + UInt16.encodingWidth
    }

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        self.glyphAssemblyOffset = .decode(bytes.baseAddress! + Offsets.glyphAssemblyOffset)
        self.variantCount = .decode(bytes.baseAddress! + Offsets.variantCount)

        do {
            let bytes = bytes.rebase(Offsets.mathGlyphVariantRecords)
            let count = Int(self.variantCount)
            guard let mathGlyphVariantRecords = FlatArray<MathGlyphVariantRecord>(bytes, count)
            else {
                return nil
            }
            self.mathGlyphVariantRecords = mathGlyphVariantRecords
        }
    }

    static var minWidth: Int = Offsets.mathGlyphVariantRecords

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathGlyphConstructionTable? {
        MathGlyphConstructionTable(bytes)
    }
}
