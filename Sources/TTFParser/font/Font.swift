// Copyright 2024 Lie Yan

import Foundation

public struct Font {
    private let bytes: UnsafeBufferPointer<UInt8>

    let tableDirectory: TableDirectory

    // MARK: - Required

    public let head: HeadTable
    public let hhea: HheaTable
    public let hmtx: HmtxTable // dependent on hhea and maxp
    public let maxp: MaxpTable

    // MARK: - Advanced

    public let math: MathTable?

    public init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        self.bytes = bytes

        guard let tableDirectory = TableDirectory.decode(bytes) else {
            return nil
        }
        self.tableDirectory = tableDirectory

        func tableOffset(_ tag: Tag) -> Offset32? {
            tableDirectory.tableRecords.get(tag)?.offset
        }

        // head
        guard let head: HeadTable = tableOffset(#tag("head"))?.lift(bytes)
        else {
            return nil
        }
        self.head = head

        // hhea
        guard let hhea: HheaTable = tableOffset(#tag("hhea"))?.lift(bytes)
        else {
            return nil
        }
        self.hhea = hhea

        // maxp
        guard let maxp: MaxpTable = tableOffset(#tag("maxp"))?.lift(bytes)
        else {
            return nil
        }
        self.maxp = maxp

        // hmtx
        guard
            let offset = tableOffset(#tag("hmtx"))?.offsetValue,
            let hmtx = HmtxTable(bytes.rebase(offset),
                                 Int(hhea.numberOfHMetrics),
                                 Int(maxp.numGlyphs))
        else {
            return nil
        }
        self.hmtx = hmtx

        // math
        self.math = tableOffset(#tag("MATH"))?.lift(self.bytes)
    }
}
