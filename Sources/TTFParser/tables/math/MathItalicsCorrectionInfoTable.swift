// Copyright 2024 Lie Yan

struct MathItalicsCorrectionInfoTable {
    // MARK: -  Properties

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

     Count given by ``italicsCorrectionCount``.
     */
    public let italicsCorrections: FlatArray<MathValueRecord>

    private let bytes: UnsafeBufferPointer<UInt8>

    // MARK: - Offsets

    private enum Offsets {
        static let italicsCorrectionCoverageOffset = 0
        static let italicsCorrectionCount = italicsCorrectionCoverageOffset + Offset16.encodingWidth
        static let italicsCorrections = italicsCorrectionCount + UInt16.encodingWidth
    }

    public init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.leastWidth else {
            return nil
        }

        let baseAddress = bytes.baseAddress!

        self.italicsCorrectionCoverageOffset = Offset16.decode(baseAddress + Offsets.italicsCorrectionCoverageOffset)
        self.italicsCorrectionCount = UInt16.decode(baseAddress + Offsets.italicsCorrectionCount)

        guard let italicsCorrections =
            FlatArray<MathValueRecord>(
                bytes.rebase(Offsets.italicsCorrections),
                Int(self.italicsCorrectionCount)
            )
        else {
            return nil
        }

        self.italicsCorrections = italicsCorrections
        self.bytes = bytes
    }

    static var leastWidth: Int = Offsets.italicsCorrections

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathItalicsCorrectionInfoTable? {
        MathItalicsCorrectionInfoTable(bytes)
    }
}
