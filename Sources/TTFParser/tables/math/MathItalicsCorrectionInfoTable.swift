// Copyright 2024 Lie Yan

struct MathItalicsCorrectionInfoTable: SafeDecodable {
    /**
     Offset to Coverage table, from the beginning of MathItalicsCorrectionInfo table.
     */
    public let italicsCorrectionCoverageOffset: Offset16

    /**
     Number of italics correction values. Should coincide with the number of covered glyphs.
     */
    public let italicsCorrectionCount: UInt16

    /**
     Array of MathValueRecords defining italics correction values for each covered glyph.

     Length given by italicsCorrectionCount.
     */
    public let italicsCorrections: FlatArray<MathValueRecord>

    private enum Offsets {
        static let italicsCorrectionCoverageOffset = 0
        static let italicsCorrectionCount = italicsCorrectionCoverageOffset + Offset16.encodingWidth
        static let italicsCorrections = italicsCorrectionCount + UInt16.encodingWidth
    }

    private let bytes: UnsafeBufferPointer<UInt8>

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        self.italicsCorrectionCoverageOffset = .decode(bytes.baseAddress! + Offsets.italicsCorrectionCoverageOffset)
        self.italicsCorrectionCount = .decode(bytes.baseAddress! + Offsets.italicsCorrectionCount)

        do {
            let bytes = bytes.rebase(Offsets.italicsCorrections)
            let count = Int(self.italicsCorrectionCount)
            guard let italicsCorrections = FlatArray<MathValueRecord>(bytes, count) else {
                return nil
            }
            self.italicsCorrections = italicsCorrections
        }
        self.bytes = bytes
    }

    static var minWidth: Int = Offsets.italicsCorrections

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathItalicsCorrectionInfoTable? {
        MathItalicsCorrectionInfoTable(bytes)
    }
}
