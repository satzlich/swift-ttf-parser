// Copyright 2024 Lie Yan

struct TableDirectory: SafeDecodable {
    public let sfntVersion: UInt32
    public let numTables: UInt16
    public let searchRange: UInt16
    public let entrySelector: UInt16
    public let rangeShift: UInt16
    public let tableRecords: FlatArray<TableRecord>

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        self.sfntVersion = UInt32.decode(bytes.baseAddress! + Offsets.sfntVersion)

        guard
            self.sfntVersion == 0x0001_0000 ||
            self.sfntVersion == #fourCharCode("OTTO")
        else {
            return nil
        }

        self.numTables = UInt16.decode(bytes.baseAddress! + Offsets.numTables)
        self.searchRange = UInt16.decode(bytes.baseAddress! + Offsets.searchRange)
        self.entrySelector = UInt16.decode(bytes.baseAddress! + Offsets.entrySelector)
        self.rangeShift = UInt16.decode(bytes.baseAddress! + Offsets.rangeShift)

        do {
            let bytes = bytes.rebase(Offsets.tableRecords)
            let count = Int(self.numTables)
            guard let tablRecords = FlatArray<TableRecord>(bytes, count) else {
                return nil
            }
            self.tableRecords = tablRecords
        }
    }

    private enum Offsets {
        static let sfntVersion = 0
        static let numTables = sfntVersion + UInt32.encodingWidth
        static let searchRange = numTables + UInt16.encodingWidth
        static let entrySelector = searchRange + UInt16.encodingWidth
        static let rangeShift = entrySelector + UInt16.encodingWidth
        static let tableRecords = rangeShift + UInt16.encodingWidth
    }

    public static let minWidth: Int = Offsets.tableRecords

    public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> TableDirectory? {
        TableDirectory(bytes)
    }
}
