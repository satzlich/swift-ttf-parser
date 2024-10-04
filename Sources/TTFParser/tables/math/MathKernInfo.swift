// Copyright 2024 Lie Yan

struct MathKernInfo {
    private let record: MathKernInfoRecord
    private let bytes: UnsafeBufferPointer<UInt8>

    init(_ record: MathKernInfoRecord, _ bytes: UnsafeBufferPointer<UInt8>) {
        self.record = record
        self.bytes = bytes
    }

    public var topRightMathKern: MathKernTable? {
        record.topRightMathKernOffset.lift(bytes)
    }

    public var topLeftMathKern: MathKernTable? {
        record.topLeftMathKernOffset.lift(bytes)
    }

    public var bottomRightMathKern: MathKernTable? {
        record.bottomRightMathKernOffset.lift(bytes)
    }

    public var bottomLeftMathKern: MathKernTable? {
        record.bottomLeftMathKernOffset.lift(bytes)
    }
}
