// Copyright 2024 Lie Yan

// MARK: - MathKernInfoTable

struct MathKernInfoTable: SafeDecodable {
    /**
     Offset to Coverage table, from the beginning of the MathKernInfo table.
     */
    public let mathKernCoverageOffset: Offset16

    /**
     Number of MathKernInfoRecords. Must be the same as the number of glyph IDs
     referenced in the Coverage table.
     */
    public let mathKernCount: UInt16

    /**
     Array of MathKernInfoRecords, one for each covered glyph. Array length given by mathKernCount.
     */
    public let mathKernInfoRecords: FlatArray<MathKernInfoRecord>

    private enum Offsets {
        static let mathKernCoverageOffset = 0
        static let mathKernCount = mathKernCoverageOffset + Offset16.encodingWidth
        static let mathKernInfoRecords = mathKernCount + UInt16.encodingWidth
    }

    private let bytes: UnsafeBufferPointer<UInt8>

    private init? (_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        self.mathKernCoverageOffset = Offset16.decode(bytes.baseAddress! + Offsets.mathKernCoverageOffset)
        self.mathKernCount = UInt16.decode(bytes.baseAddress! + Offsets.mathKernCount)

        do {
            let bytes = bytes.rebase(Offsets.mathKernInfoRecords)
            let count = Int(self.mathKernCount)
            guard let mathKernInfoRecords = FlatArray<MathKernInfoRecord>(bytes, count) else {
                return nil
            }
            self.mathKernInfoRecords = mathKernInfoRecords
        }

        self.bytes = bytes
    }

    static var minWidth: Int = Offsets.mathKernInfoRecords

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathKernInfoTable? {
        MathKernInfoTable(bytes)
    }
}

extension MathKernInfoTable {
    public var mathKernCoverage: CoverageTable? {
        self.mathKernCoverageOffset.offsetValue.flatMap {
            CoverageTable.decode(self.bytes.rebase($0))
        }
    }

    public var mathKernInfos: RecordArray<MathKernInfoRecord> {
        mathKernInfoRecords.recordArray(self.bytes)
    }
}
