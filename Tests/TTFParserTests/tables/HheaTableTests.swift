// Copyright 2024 Lie Yan

@testable import TTFParser
import Foundation
import XCTest

final class HheaTableTests: XCTestCase {
    func testHheaTable() {
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

        guard let font = Font(bytes) else {
            XCTFail("Font not found")
            return
        }

        let hhea = font.hhea

        XCTAssertEqual(hhea.ascender, 1024)
        XCTAssertEqual(hhea.descender, -400)
        XCTAssertEqual(hhea.caretSlopeRise, 1)
    }
}
