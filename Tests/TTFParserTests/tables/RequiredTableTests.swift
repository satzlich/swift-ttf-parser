// Copyright 2024 Lie Yan

import TTFParser
import Foundation
import XCTest

final class RequiredTableTests: XCTestCase {
    static var data: Data?
    static var font: Font?

    override class func setUp() {
        let fontData = FontUtils.loadFont(forResource: "demo", withExtension: "ttf", subdirectory: "fonts")

        self.data = fontData?.data
        self.font = fontData?.font
    }

    func testHead() {
        guard let head = Self.font?.head
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
        guard let hhea = Self.font?.hhea
        else {
            XCTFail("Hhea not found")
            return
        }

        XCTAssertEqual(hhea.ascender, 1024)
        XCTAssertEqual(hhea.descender, -400)
        XCTAssertEqual(hhea.caretSlopeRise, 1)
    }
}
