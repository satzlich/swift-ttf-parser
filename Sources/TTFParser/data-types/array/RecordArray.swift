// Copyright 2024 Lie Yan

// MARK: - RecordArray

/**
 Array of lifted records.
 */
struct RecordArray<Record: FixedDecodable & LiftableRecord> {
    typealias Element = Record.LiftResult

    private let records: FlatArray<Record>
    private let bytes: UnsafeBufferPointer<UInt8>

    init(_ records: FlatArray<Record>,
         _ bytes: UnsafeBufferPointer<UInt8>)
    {
        self.records = records
        self.bytes = bytes
    }

    public var count: Int {
        records.count
    }

    public func get(_ index: Int) -> Element? {
        records.get(index)?.lift(bytes)
    }
}

// MARK: - RecordArray + ArrayProtocol

extension RecordArray: ArrayProtocol {
}
