// Copyright 2024 Lie Yan

// MARK: - MathKernTable

public struct MathKernTable: SafeDecodable {
    /**
     Number of heights at which the kern value changes.
     */
    public let heightCount: UInt16

    /**
     Array of correction heights, in design units, sorted from lowest to highest.
     Array length given by heightCount.
     */
    public let correctionHeights: FlatArray<MathValueRecord>

    /**
     Array of kerning values for different height ranges. Negative values are used
     to move glyphs closer to each other. Array length given by heightCount + 1.
     */
    public let kernValues: FlatArray<MathValueRecord>

    private enum Offsets {
        static let heightCount = 0
        static let correctionHeights = heightCount + UInt16.encodingWidth
        static func kernValues(_ heightCount: Int) -> Int {
            self.correctionHeights + heightCount * MathValueRecord.encodingWidth
        }
    }

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        self.heightCount = UInt16.decode(bytes.baseAddress! + Offsets.heightCount)

        do {
            let bytes = bytes.rebase(Offsets.correctionHeights)
            let count = Int(self.heightCount)
            guard let correctionHeights = FlatArray<MathValueRecord>(bytes, count) else {
                return nil
            }
            self.correctionHeights = correctionHeights
        }

        do {
            let bytes = bytes.rebase(Offsets.kernValues(Int(heightCount)))
            let count = Int(self.heightCount + 1)
            guard let kernValues = FlatArray<MathValueRecord>(bytes, count) else {
                return nil
            }
            self.kernValues = kernValues
        }
    }

    public static let minWidth: Int = Offsets.correctionHeights + MathValueRecord.encodingWidth

    public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathKernTable? {
        MathKernTable(bytes)
    }
}

extension MathKernTable {
    func get(_ height: Int16) -> Int16 {
        let index = correctionHeights.upperBound(height) { $0 < $1.value }
        return kernValues.at(index)?.value ?? 0
    }
}
