// Copyright 2024 Lie Yan

@testable import TTFParser
import Foundation
import XCTest

// MARK: - TableDirectoryTests

final class TableDirectoryTests: XCTestCase {
    func testTableDirectory() {
        guard let fileURL = Bundle.module.url(forResource: "demo",
                                              withExtension: "ttf",
                                              subdirectory: "fonts")
        else {
            XCTFail("File not found")
            return
        }

        guard let data = try? Data(contentsOf: fileURL)
        else {
            XCTFail("Data not found")
            return
        }

        let tableDirectory = data.withUnsafeBytes {
            let bytes = $0.bindMemory(to: UInt8.self)
            return TableDirectory.decode(bytes)
        }

        guard let tableDirectory = tableDirectory
        else {
            XCTFail("Table directory not found")
            return
        }

        XCTAssertEqual(tableDirectory.sfntVersion, 0x0001_0000)
        XCTAssertEqual(tableDirectory.numTables, 7)

        do {
            let tableTags = tableDirectory.tableRecords.map { $0.tableTag }
            let expected = [
                #tag("head"),
                #tag("hhea"),
                #tag("maxp"),
                #tag("hmtx"),
                #tag("cmap"),
                #tag("loca"),
                #tag("glyf"),
            ].sorted()

            XCTAssertEqual(tableTags, expected)
        }
    }
}
