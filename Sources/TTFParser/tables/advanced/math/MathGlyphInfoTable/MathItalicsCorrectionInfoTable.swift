// Copyright 2024 Lie Yan

// MARK: - MathItalicsCorrectionInfoTable

struct MathItalicsCorrectionInfoTable: SafeDecodable {
    private let italicsCorrections: FlatArray<MathValueRecord>
    private let italicsCorrectionCoverage: CoverageTable?
    private let bytes: UnsafeBufferPointer<UInt8>

    private enum Offsets {
        static let italicsCorrectionCoverageOffset = 0
        static let italicsCorrectionCount = italicsCorrectionCoverageOffset + Offset16.encodingWidth
        static let italicsCorrections = italicsCorrectionCount + UInt16.encodingWidth
    }

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        let italicsCorrectionCoverageOffset
            = Offset16.decode(bytes.baseAddress! + Offsets.italicsCorrectionCoverageOffset)
        let italicsCorrectionCount = UInt16.decode(bytes.baseAddress! + Offsets.italicsCorrectionCount)

        guard italicsCorrectionCount > 0 else {
            return nil
        }

        let recordsBytes = bytes.rebase(Offsets.italicsCorrections)

        guard let italicsCorrections
            = FlatArray<MathValueRecord>(recordsBytes, Int(italicsCorrectionCount))
        else {
            return nil
        }
        self.italicsCorrections = italicsCorrections
        self.italicsCorrectionCoverage = italicsCorrectionCoverageOffset.lift(bytes)

        self.bytes = bytes
    }

    static let minWidth: Int = Offsets.italicsCorrections

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathItalicsCorrectionInfoTable? {
        MathItalicsCorrectionInfoTable(bytes)
    }
}

extension MathItalicsCorrectionInfoTable {
    public func get(_ glyphId: UInt16) -> MathValue? {
        guard let index = italicsCorrectionCoverage?.get(glyphId) else {
            return nil
        }
        return italicsCorrections.at(Int(index))?.lift(bytes)
    }
}
