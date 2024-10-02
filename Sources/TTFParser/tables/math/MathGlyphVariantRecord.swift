// Copyright 2024 Lie Yan

struct MathGlyphVariantRecord: FixedDecodable {
    

    /// Glyph ID for the variant.
    public let variantGlyph: UInt16

    /// Advance width/height, in design units, of the variant, in the direction of
    /// requested glyph extension.
    public let advanceMeasurement: UFWORD

    

    private enum Offsets {
        static let variantGlyph = 0
        static let advanceMeasurement = variantGlyph + UInt16.encodingWidth
    }

    private init(_ bytes: UnsafePointer<UInt8>) {
        self.variantGlyph = UInt16.decode(bytes + Offsets.variantGlyph)
        self.advanceMeasurement = UFWORD.decode(bytes + Offsets.advanceMeasurement)
    }

    

    static var encodingWidth: Int =
        Offsets.advanceMeasurement + UFWORD.encodingWidth

    static func decode(_ bytes: UnsafePointer<UInt8>) -> MathGlyphVariantRecord {
        MathGlyphVariantRecord(bytes)
    }
}
