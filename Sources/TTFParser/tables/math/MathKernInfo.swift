// Copyright 2024 Lie Yan

struct MathKernInfo {
    private let record: MathKernInfoRecord
    private let bytes: UnsafeBufferPointer<UInt8>

    init(_ record: MathKernInfoRecord, _ bytes: UnsafeBufferPointer<UInt8>) {
        self.record = record
        self.bytes = bytes
    }

    public var topRightMathKern: MathKernTable? {
        record.topRightMathKernOffset.offsetValue.flatMap {
            MathKernTable.decode(bytes.rebase($0))
        }
    }

    public var topLeftMathKern: MathKernTable? {
        record.topLeftMathKernOffset.offsetValue.flatMap {
            MathKernTable.decode(bytes.rebase($0))
        }
    }

    public var bottomRightMathKern: MathKernTable? {
        record.bottomRightMathKernOffset.offsetValue.flatMap {
            MathKernTable.decode(bytes.rebase($0))
        }
    }

    public var bottomLeftMathKern: MathKernTable? {
        record.bottomLeftMathKernOffset.offsetValue.flatMap {
            MathKernTable.decode(bytes.rebase($0))
        }
    }
}
