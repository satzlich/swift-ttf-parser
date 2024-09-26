// Copyright 2024 Lie Yan

public struct MathKernInfo {
    private let record: MathKernInfoRecord
    private let bytes: UnsafeBufferPointer<UInt8>

    init(_ record: MathKernInfoRecord, _ bytes: UnsafeBufferPointer<UInt8>) {
        self.record = record
        self.bytes = bytes
    }

    public var topRight: MathKernTable? {
        record.topRightMathKernOffset.lift(bytes)
    }

    public var topLeft: MathKernTable? {
        record.topLeftMathKernOffset.lift(bytes)
    }

    public var bottomRight: MathKernTable? {
        record.bottomRightMathKernOffset.lift(bytes)
    }

    public var bottomLeft: MathKernTable? {
        record.bottomLeftMathKernOffset.lift(bytes)
    }
}
