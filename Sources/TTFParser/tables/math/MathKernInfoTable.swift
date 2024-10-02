// Copyright 2024 Lie Yan

/*
 Offset16    mathKernCoverageOffset    Offset to Coverage table, from the beginning of the MathKernInfo table.
 uint16    mathKernCount    Number of MathKernInfoRecords. Must be the same as the number of glyph IDs referenced in the Coverage table.
 MathKernInfoRecord    mathKernInfoRecords[mathKernCount]    Array of MathKernInfoRecords, one for each covered glyph.
 */

struct MathKernInfoTable: LinkedDecodable {
    /**
     Offset to Coverage table, from the beginning of the MathKernInfo table.
     */
    public let mathKernCoverageOffset: Offset16

    /**
     Number of MathKernInfoRecords. Must be the same as the number of glyph IDs referenced in the Coverage table.
     */
    public let mathKernCount: UInt16

    /**
     Array of MathKernInfoRecords, one for each covered glyph.

     Count is given by ``mathKernCount``.
     */
    public let mathKernInfoRecords: FlatArray<MathKernInfoRecord>

    

    private enum Offsets {
        static let mathKernCoverageOffset = 0
        static let mathKernCount = mathKernCoverageOffset + Offset16.encodingWidth
        static let mathKernInfoRecords = mathKernCount + UInt16.encodingWidth
    }

    private let bytes: UnsafeBufferPointer<UInt8>

    private init? (_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.leastWidth else {
            return nil
        }

        let baseAddress = bytes.baseAddress!

        self.mathKernCoverageOffset = Offset16.decode(baseAddress + Offsets.mathKernCoverageOffset)
        self.mathKernCount = UInt16.decode(baseAddress + Offsets.mathKernCount)

        guard let mathKernInfoRecords =
            FlatArray<MathKernInfoRecord>(
                bytes.rebase(Offsets.mathKernInfoRecords),
                Int(self.mathKernCount)
            )
        else {
            return nil
        }

        self.mathKernInfoRecords = mathKernInfoRecords
        self.bytes = bytes
    }

    static var leastWidth: Int = Offsets.mathKernInfoRecords

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathKernInfoTable? {
        MathKernInfoTable(bytes)
    }
}
