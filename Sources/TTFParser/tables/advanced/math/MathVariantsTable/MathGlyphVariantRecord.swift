// Copyright 2024 Lie Yan

public struct MathGlyphVariantRecord: FixedDecodable {
    /// Glyph ID for the variant.
    public let variantGlyph: UInt16

    /// Advance width/height, in design units, of the variant, in the direction of
    /// requested glyph extension.
    public let advanceMeasurement: UFWORD

    private enum _Offsets {
        static let variantGlyph = 0
        static let advanceMeasurement = variantGlyph + UInt16.encodingWidth
    }

    private init(_ bytes: UnsafePointer<UInt8>) {
        self.variantGlyph = UInt16.decode(bytes + _Offsets.variantGlyph)
        self.advanceMeasurement = UFWORD.decode(bytes + _Offsets.advanceMeasurement)
    }

    public static var encodingWidth: Int = _Offsets.advanceMeasurement + UFWORD.encodingWidth

    public static func decode(_ bytes: UnsafePointer<UInt8>) -> MathGlyphVariantRecord {
        MathGlyphVariantRecord(bytes)
    }
}
