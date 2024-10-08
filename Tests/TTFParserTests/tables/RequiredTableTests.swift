// Copyright 2024 Lie Yan

@testable import TTFParser
import Foundation
import XCTest

final class RequiredTableTests: XCTestCase {
    static var data: Data?
    static var font: Font?

    override class func setUp() {
        let fontData = FontUtils.loadFont(forResource: "demo", withExtension: "ttf", subdirectory: "fonts")

        data = fontData?.data
        font = fontData?.font
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

    func testHmtx() {
        guard let hmtx = Self.font?.hmtx
        else {
            XCTFail("Hmtx not found")
            return
        }

        XCTAssertEqual(hmtx.hMetrics.count, 2)
        XCTAssertEqual(hmtx.leftSideBearings.count, 0)
    }

    func testMaxp() {
        guard let maxp = Self.font?.maxp
        else {
            XCTFail("Maxp not found")
            return
        }

        XCTAssertEqual(maxp.numGlyphs, 2)

        guard case let .version1(version) = maxp
        else {
            XCTFail("Maxp version not found")
            return
        }
        XCTAssertEqual(version.maxPoints, 11)
        XCTAssertEqual(version.maxContours, 2)
    }

    func testPost() {
        let fontData = FontUtils.loadFont(forResource: "MathTestFontEmpty",
                                          withExtension: "otf",
                                          subdirectory: "fonts")
        guard let font = fontData?.font
        else {
            XCTFail("Fail to load font")
            return
        }

        guard let post = font.post
        else {
            XCTFail("Post not found")
            return
        }

        XCTAssertEqual(post.version, Version16Dot16(0x0003_0000))
        XCTAssertEqual(post.nameForGlyph(10), nil)
    }
}
