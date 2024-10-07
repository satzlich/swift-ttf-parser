// Copyright 2024 Lie Yan

struct GlyphAssemblyTable: SafeDecodable {
    /**
     Italics correction of this GlyphAssembly. Should not depend on the assembly size.
     */
    public let italicsCorrection: MathValueRecord

    /**
     Array of GlyphPart records, from left to right (for assemblies that extend
     horizontally) or bottom to top (for assemblies that extend vertically).

     Array length given by partCount.
     */
    public let parts: FlatArray<GlyphPartRecord>

    private enum Offsets {
        static let italicsCorrection = 0
        static let partCount = italicsCorrection + MathValueRecord.encodingWidth
        static let partRecords = partCount + UInt16.encodingWidth
    }

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        self.italicsCorrection = MathValueRecord.decode(bytes.baseAddress! + Offsets.italicsCorrection)

        let partCount = UInt16.decode(bytes.baseAddress! + Offsets.partCount)

        do {
            let bytes = bytes.rebase(Offsets.partRecords)
            guard let partRecords = FlatArray<GlyphPartRecord>(bytes, Int(partCount)) else {
                return nil
            }
            self.parts = partRecords
        }
    }

    static let minWidth: Int = Offsets.partRecords

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> GlyphAssemblyTable? {
        GlyphAssemblyTable(bytes)
    }
}
