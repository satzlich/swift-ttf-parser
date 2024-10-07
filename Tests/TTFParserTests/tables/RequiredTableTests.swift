// Copyright 2024 Lie Yan

@testable import TTFParser
import Foundation
import XCTest

final class RequiredTableTests: XCTestCase {
    var data: Data?
    var font: Font?

    override func setUp() {
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

        self.data = data
        self.font = font
    }

    func testHead() {
        guard let head = font?.head
        else {
            XCTFail("Head not found")
            return
        }

        XCTAssertEqual(head.magicNumber, 0x5F0F_3CF5)
        XCTAssertEqual(head.unitsPerEm, 1000)
        XCTAssertEqual(head.lowestRecPPEM, 3)
        XCTAssertEqual(head.fontDirectionHint, 2)
    }

    func testHhea() {
        guard let hhea = font?.hhea
        else {
            XCTFail("Hhea not found")
            return
        }

        XCTAssertEqual(hhea.ascender, 1024)
        XCTAssertEqual(hhea.descender, -400)
        XCTAssertEqual(hhea.caretSlopeRise, 1)
    }
}
