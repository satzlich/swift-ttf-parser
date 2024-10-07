// Copyright 2024 Lie Yan

import Foundation

struct Font {
    private let bytes: UnsafeBufferPointer<UInt8>

    let tableDirectory: TableDirectory

    let head: HeadTable
    let hhea: HheaTable

    init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        self.bytes = bytes

        guard let tableDirectory = TableDirectory.decode(bytes) else {
            return nil
        }
        self.tableDirectory = tableDirectory

        func loadTable<T: SafeDecodable>(_ tag: Tag) -> T? {
            guard let tableRecord = tableDirectory.tableRecords[tag] else {
                return nil
            }
            return tableRecord.offset.lift(bytes)
        }

        guard let head: HeadTable = loadTable(#tag("head")) else {
            return nil
        }
        self.head = head

        guard let hhea: HheaTable = loadTable(#tag("hhea")) else {
            return nil
        }
        self.hhea = hhea
    }
}
