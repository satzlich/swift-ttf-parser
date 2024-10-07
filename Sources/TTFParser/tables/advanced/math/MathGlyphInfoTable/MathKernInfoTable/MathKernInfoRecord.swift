// Copyright 2024 Lie Yan

// MARK: - MathKernInfoRecord

struct MathKernInfoRecord: FixedDecodable {
    /// Offset to MathKern table for top right corner, from the
    /// beginning of the MathKernInfo table. May be NULL.
    let topRightMathKernOffset: Offset16

    /// Offset to MathKern table for the top left corner, from
    /// the beginning of the MathKernInfo table. May be NULL.
    let topLeftMathKernOffset: Offset16

    /// Offset to MathKern table for the bottom right corner, from
    /// the beginning of the MathKernInfo table. May be NULL.
    let bottomRightMathKernOffset: Offset16

    /// Offset to MathKern table for the bottom left corner, from
    /// the beginning of the MathKernInfo table. May be NULL.
    let bottomLeftMathKernOffset: Offset16

    private enum Offsets {
        static let topRightMathKernOffset = 0
        static let topLeftMathKernOffset = topRightMathKernOffset + Offset16.encodingWidth
        static let bottomRightMathKernOffset = topLeftMathKernOffset + Offset16.encodingWidth
        static let bottomLeftMathKernOffset = bottomRightMathKernOffset + Offset16.encodingWidth
    }

    private init(_ bytes: UnsafePointer<UInt8>) {
        self.topRightMathKernOffset = Offset16.decode(bytes + Offsets.topRightMathKernOffset)
        self.topLeftMathKernOffset = Offset16.decode(bytes + Offsets.topLeftMathKernOffset)
        self.bottomRightMathKernOffset = Offset16.decode(bytes + Offsets.bottomRightMathKernOffset)
        self.bottomLeftMathKernOffset = Offset16.decode(bytes + Offsets.bottomLeftMathKernOffset)
    }

    public static var encodingWidth: Int =
        Offsets.bottomLeftMathKernOffset + Offset16.encodingWidth

    public static func decode(_ bytes: UnsafePointer<UInt8>) -> MathKernInfoRecord {
        MathKernInfoRecord(bytes)
    }
}

// MARK: - MathKernInfoRecord + LiftableRecord

extension MathKernInfoRecord: LiftableRecord {
    typealias LiftResult = MathKernInfo

    func lift(_ bytes: UnsafeBufferPointer<UInt8>) -> MathKernInfo {
        MathKernInfo(self, bytes)
    }
}
