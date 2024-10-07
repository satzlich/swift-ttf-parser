// Copyright 2024 Lie Yan

@testable import TTFParser
import Foundation
import XCTest

final class HeadTableTests: XCTestCase {
    func testHeadTable() {
        guard let fileURL = Bundle.module.url(forResource: "demo",
                                              withExtension: "ttf",
                                              subdirectory: "fonts")
        else {
            XCTFail("File not found")
            return
        }

        guard let data = try? Data(contentsOf: fileURL) else {
            XCTFail("Data not found")
            return
        }

        let bytes = data.withUnsafeBytes { $0.bindMemory(to: UInt8.self) }

        let font = Font(bytes)
        guard let font else {
            XCTFail("Font not found")
            return
        }

        guard let tableRecord = font.tableDirectory.tableRecords[#tag("head")]
        else {
            XCTFail("Table record not found")
            return
        }

        guard let headTable: HeadTable = tableRecord.offset.lift(bytes)
        else {
            XCTFail("Head table not found")
            return
        }

        XCTAssertEqual(headTable.magicNumber, 0x5F0F_3CF5)
        XCTAssertEqual(headTable.unitsPerEm, 1000)
        XCTAssertEqual(headTable.lowestRecPPEM, 3)
        XCTAssertEqual(headTable.fontDirectionHint, 2)
    }
}
