// Copyright 2024 Lie Yan

@testable import TTFParser
import Foundation
import XCTest

final class MathTableTests: XCTestCase {
    static var dataArray: [Data] = []

    static var emptyFont: Font?
    static var partial1Font: Font?
    static var partial2Font: Font?
    static var partial3Font: Font?
    static var partial4Font: Font?
    static var fullFont: Font?

    static var emptyCTFont: CTFont?
    static var partial1CTFont: CTFont?
    static var partial2CTFont: CTFont?
    static var partial3CTFont: CTFont?
    static var partial4CTFont: CTFont?
    static var fullCTFont: CTFont?

    override class func setUp() {
        let list = ["MathTestFontEmpty",
                    "MathTestFontPartial1",
                    "MathTestFontPartial2",
                    "MathTestFontPartial3",
                    "MathTestFontPartial4",
                    "MathTestFontFull"]

        // Load fonts
        let fonts = list.compactMap {
            FontUtils.loadFont(forResource: $0,
                               withExtension: "otf",
                               subdirectory: "fonts")
        }

        for (_, data) in fonts {
            dataArray.append(data)
        }

        guard fonts.count == list.count
        else {
            fatalError("Failed to load fonts")
        }

        emptyFont = fonts[0].font
        partial1Font = fonts[1].font
        partial2Font = fonts[2].font
        partial3Font = fonts[3].font
        partial4Font = fonts[4].font
        fullFont = fonts[5].font

        // Load CTFonts

        let ctFonts = list.compactMap {
            FontUtils.loadCTFont(forResource: $0,
                                 withExtension: "otf",
                                 subdirectory: "fonts")
        }

        guard ctFonts.count == list.count
        else {
            fatalError("Failed to load fonts")
        }

        emptyCTFont = ctFonts[0]
        partial1CTFont = ctFonts[1]
        partial2CTFont = ctFonts[2]
        partial3CTFont = ctFonts[3]
        partial4CTFont = ctFonts[4]
        fullCTFont = ctFonts[5]
    }

    func testConstants() {
        XCTAssertNil(Self.emptyFont?.math?.constants)

        guard let constants = Self.fullFont?.math?.constants
        else {
            XCTFail("Constants not found")
            return
        }

        XCTAssertEqual(constants.scriptPercentScaleDown, 87)
        XCTAssertEqual(constants.scriptScriptPercentScaleDown, 76)
        XCTAssertEqual(constants.delimitedSubFormulaMinHeight, 100)
        XCTAssertEqual(constants.displayOperatorMinHeight, 200)
        AssertEqual(constants.mathLeading, 300)
        AssertEqual(constants.axisHeight, 400)
        AssertEqual(constants.accentBaseHeight, 500)
        AssertEqual(constants.flattenedAccentBaseHeight, 600)
        AssertEqual(constants.subscriptShiftDown, 700)
        AssertEqual(constants.subscriptTopMax, 800)
        AssertEqual(constants.subscriptBaselineDropMin, 900)
        AssertEqual(constants.superscriptShiftUp, 1100)
        AssertEqual(constants.superscriptShiftUpCramped, 1200)
        AssertEqual(constants.superscriptBottomMin, 1300)
        AssertEqual(constants.superscriptBaselineDropMax, 1400)
        AssertEqual(constants.subSuperscriptGapMin, 1500)
        AssertEqual(constants.superscriptBottomMaxWithSubscript, 1600)
        AssertEqual(constants.spaceAfterScript, 1700)
        AssertEqual(constants.upperLimitGapMin, 1800)
        AssertEqual(constants.upperLimitBaselineRiseMin, 1900)
        AssertEqual(constants.lowerLimitGapMin, 2200)
        AssertEqual(constants.lowerLimitBaselineDropMin, 2300)
        AssertEqual(constants.stackTopShiftUp, 2400)
        AssertEqual(constants.stackTopDisplayStyleShiftUp, 2500)
        AssertEqual(constants.stackBottomShiftDown, 2600)
        AssertEqual(constants.stackBottomDisplayStyleShiftDown, 2700)
        AssertEqual(constants.stackGapMin, 2800)
        AssertEqual(constants.stackDisplayStyleGapMin, 2900)
        AssertEqual(constants.stretchStackTopShiftUp, 3000)
        AssertEqual(constants.stretchStackBottomShiftDown, 3100)
        AssertEqual(constants.stretchStackGapAboveMin, 3200)
        AssertEqual(constants.stretchStackGapBelowMin, 3300)
        AssertEqual(constants.fractionNumeratorShiftUp, 3400)
        AssertEqual(constants.fractionNumeratorDisplayStyleShiftUp, 3500)
        AssertEqual(constants.fractionDenominatorShiftDown, 3600)
        AssertEqual(constants.fractionDenominatorDisplayStyleShiftDown, 3700)
        AssertEqual(constants.fractionNumeratorGapMin, 3800)
        AssertEqual(constants.fractionNumDisplayStyleGapMin, 3900)
        AssertEqual(constants.fractionRuleThickness, 4000)
        AssertEqual(constants.fractionDenominatorGapMin, 4100)
        AssertEqual(constants.fractionDenomDisplayStyleGapMin, 4200)
        AssertEqual(constants.skewedFractionHorizontalGap, 4300)
        AssertEqual(constants.skewedFractionVerticalGap, 4400)
        AssertEqual(constants.overbarVerticalGap, 4500)
        AssertEqual(constants.overbarRuleThickness, 4600)
        AssertEqual(constants.overbarExtraAscender, 4700)
        AssertEqual(constants.underbarVerticalGap, 4800)
        AssertEqual(constants.underbarRuleThickness, 4900)
        AssertEqual(constants.underbarExtraDescender, 5000)
        AssertEqual(constants.radicalVerticalGap, 5100)
        AssertEqual(constants.radicalDisplayStyleVerticalGap, 5200)
        AssertEqual(constants.radicalRuleThickness, 5300)
        AssertEqual(constants.radicalExtraAscender, 5400)
        AssertEqual(constants.radicalKernBeforeDegree, 5500)
        AssertEqual(constants.radicalKernAfterDegree, 5600)
        XCTAssertEqual(constants.radicalDegreeBottomRaisePercent, 65)
    }

    func testItalicsCorrections() {
        XCTAssertNil(Self.emptyFont?.math?.glyphInfo?.italicsCorrectionInfo)

        XCTAssertNil(Self.partial1Font?.math?.glyphInfo?.italicsCorrectionInfo)

        do {
            guard let italicsCorrectionInfo = Self.partial2Font?.math?.glyphInfo?.italicsCorrectionInfo
            else {
                XCTFail("Italics correction info not found")
                return
            }

            XCTAssertEqual(italicsCorrectionInfo.italicsCorrectionCount, 0)
        }

        do {
            guard let italicsCorrectionInfo = Self.fullFont?.math?.glyphInfo?.italicsCorrectionInfo
            else {
                XCTFail("Italics correction info not found")
                return
            }

            var glyphId: UInt16

            glyphId = Self.fullCTFont!.getGlyphWithName("space")
            XCTAssertNil(italicsCorrectionInfo[glyphId])

            glyphId = Self.fullCTFont!.getGlyphWithName("A")
            AssertEqual(italicsCorrectionInfo[glyphId]!, 197)

            glyphId = Self.fullCTFont!.getGlyphWithName("B")
            AssertEqual(italicsCorrectionInfo[glyphId]!, 150)

            glyphId = Self.fullCTFont!.getGlyphWithName("C")
            AssertEqual(italicsCorrectionInfo[glyphId]!, 452)
        }
    }

    func AssertEqual(_ actual: MathValueRecord, _ expected: Int16) {
        XCTAssertEqual(actual.value, expected)
    }

    func AssertEqual(_ actual: MathValue, _ expected: Int16) {
        XCTAssertEqual(actual.value, expected)
    }
}
