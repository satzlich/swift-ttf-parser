// Copyright 2024 Lie Yan

struct MathKernTable: SafeDecodable {
    

    /**
     Number of heights at which the kern value changes.
     */
    public let heightCount: UInt16

    /**
     Array of correction heights, in design units, sorted from lowest to highest.

     Count given by ``heightCount``.
     */
    public let correctionHeights: FlatArray<MathValueRecord>

    /**
     Array of kerning values for different height ranges. Negative values are used to move glyphs closer to each other.

     Count given by ``heightCount + 1``.
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

        let baseAddress = bytes.baseAddress!

        self.heightCount = UInt16.decode(baseAddress + Offsets.heightCount)

        guard let correctionHeights =
            FlatArray<MathValueRecord>(
                bytes.rebase(Offsets.correctionHeights),
                Int(self.heightCount)
            )
        else {
            return nil
        }

        guard let kernValues =
            FlatArray<MathValueRecord>(
                bytes.rebase(Offsets.kernValues(Int(heightCount))),
                Int(self.heightCount + 1)
            )
        else {
            return nil
        }

        self.correctionHeights = correctionHeights
        self.kernValues = kernValues
    }

    static var minWidth: Int = Offsets.correctionHeights + MathValueRecord.encodingWidth

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathKernTable? {
        MathKernTable(bytes)
    }
}
