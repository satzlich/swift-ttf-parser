// Copyright 2024 Lie Yan

struct GlyphAssemblyTable: SafeDecodable {
    /**
     Italics correction of this GlyphAssembly. Should not depend on the assembly size.
     */
    public let italicsCorrection: MathValueRecord

    /**
     Number of parts in this assembly.
     */
    public let partCount: UInt16

    /**
     Array of GlyphPart records, from left to right (for assemblies that extend
     horizontally) or bottom to top (for assemblies that extend vertically).

     Count given by ``partCount``.
     */
    public let partRecords: FlatArray<GlyphPartRecord>

    private enum Offsets {
        static let italicsCorrection = 0
        static let partCount = italicsCorrection + MathValueRecord.encodingWidth
        static let partRecords = partCount + UInt16.encodingWidth
    }

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        let baseAddress = bytes.baseAddress!

        self.italicsCorrection = MathValueRecord.decode(baseAddress + Offsets.italicsCorrection)
        self.partCount = UInt16.decode(baseAddress + Offsets.partCount)

        guard let partRecords =
            FlatArray<GlyphPartRecord>(
                bytes.rebase(Offsets.partRecords),
                Int(self.partCount)
            )
        else {
            return nil
        }

        self.partRecords = partRecords
    }

    static var minWidth: Int = Offsets.partRecords

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> GlyphAssemblyTable? {
        GlyphAssemblyTable(bytes)
    }
}
