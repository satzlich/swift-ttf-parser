// Copyright 2024 Lie Yan

// MARK: - RecordArray

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

    subscript(index: Int) -> Element? {
        records[index]?.lift(bytes)
    }
}
