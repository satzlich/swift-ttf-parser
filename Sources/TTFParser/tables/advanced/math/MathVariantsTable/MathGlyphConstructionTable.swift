// Copyright 2024 Lie Yan

// MARK: - MathGlyphConstructionTable

public struct MathGlyphConstructionTable: SafeDecodable {
    public let assembly: GlyphAssemblyTable?

    /**
     MathGlyphVariantRecords for alternative variants of the glyphs.
     Array length given by variantCount.
     */
    public let variants: FlatArray<MathGlyphVariantRecord>

    private enum Offsets {
        static let glyphAssemblyOffset = 0
        static let variantCount = glyphAssemblyOffset + Offset16.encodingWidth
        static let mathGlyphVariantRecords = variantCount + UInt16.encodingWidth
    }

    private let bytes: UnsafeBufferPointer<UInt8>

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        let glyphAssemblyOffset = Offset16.decode(bytes.baseAddress! + Offsets.glyphAssemblyOffset)
        self.assembly = glyphAssemblyOffset.lift(bytes)

        let variantCount = UInt16.decode(bytes.baseAddress! + Offsets.variantCount)

        let recordsBytes = bytes.rebase(Offsets.mathGlyphVariantRecords)
        guard let mathGlyphVariantRecords
            = FlatArray<MathGlyphVariantRecord>(recordsBytes, Int(variantCount))
        else {
            return nil
        }
        self.variants = mathGlyphVariantRecords

        self.bytes = bytes
    }

    public static var minWidth: Int = Offsets.mathGlyphVariantRecords

    public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathGlyphConstructionTable? {
        MathGlyphConstructionTable(bytes)
    }
}
