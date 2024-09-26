// Copyright 2024 Lie Yan

protocol LiftableRecord {
    associatedtype LiftResult

    func lift(_ bytes: UnsafeBufferPointer<UInt8>) -> LiftResult
}
