// Copyright 2024 Lie Yan

// MARK: - MathKernInfoTable

struct MathKernInfoTable: SafeDecodable {
    private let mathKernCoverage: CoverageTable
    private let mathKernInfos: RecordArray<MathKernInfoRecord>

    private enum Offsets {
        static let mathKernCoverageOffset = 0
        static let mathKernCount = mathKernCoverageOffset + Offset16.encodingWidth
        static let mathKernInfoRecords = mathKernCount + UInt16.encodingWidth
    }

    private init? (_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        let coverageOffset = Offset16.decode(bytes.baseAddress! + Offsets.mathKernCoverageOffset)
        guard coverageOffset.offsetValue != nil else {
            return nil
        }

        let mathKernCount = UInt16.decode(bytes.baseAddress! + Offsets.mathKernCount)
        guard mathKernCount > 0 else {
            return nil
        }

        let recordsBytes = bytes.rebase(Offsets.mathKernInfoRecords)
        guard let mathKernInfoRecords
            = FlatArray<MathKernInfoRecord>(recordsBytes, Int(mathKernCount))
        else {
            return nil
        }

        guard let mathKernCoverage: CoverageTable = coverageOffset.lift(bytes)
        else {
            return nil
        }
        self.mathKernCoverage = mathKernCoverage
        self.mathKernInfos = mathKernInfoRecords.recordArray(bytes)
    }

    static let minWidth: Int = Offsets.mathKernInfoRecords

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathKernInfoTable? {
        MathKernInfoTable(bytes)
    }
}

extension MathKernInfoTable {
    public func get(_ glyphId: UInt16) -> MathKernInfo? {
        guard let index = mathKernCoverage.get(glyphId) else {
            return nil
        }
        return mathKernInfos.at(Int(index))
    }
}
