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
        XCTAssertNil(Self.partial2Font?.math?.glyphInfo?.italicsCorrectionInfo)

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

    func testTopAccentAttachment() {
        XCTAssertNil(Self.emptyFont?.math?.glyphInfo?.topAccentAttachment)
        XCTAssertNil(Self.partial1Font?.math?.glyphInfo?.topAccentAttachment)
        XCTAssertNil(Self.partial2Font?.math?.glyphInfo?.topAccentAttachment)

        do {
            guard let topAccentAttachment = Self.fullFont?.math?.glyphInfo?.topAccentAttachment
            else {
                XCTFail("Top accent attachment not found")
                return
            }

            var glyphId: UInt16

            // space, D, E, F

            glyphId = Self.fullCTFont!.getGlyphWithName("space")
            XCTAssertNil(topAccentAttachment[glyphId])

            glyphId = Self.fullCTFont!.getGlyphWithName("D")
            AssertEqual(topAccentAttachment[glyphId]!, 374)

            glyphId = Self.fullCTFont!.getGlyphWithName("E")
            AssertEqual(topAccentAttachment[glyphId]!, 346)

            glyphId = Self.fullCTFont!.getGlyphWithName("F")
            AssertEqual(topAccentAttachment[glyphId]!, 318)
        }
    }

    func testExtendedShapes() {
        XCTAssertNil(Self.emptyFont?.math?.glyphInfo?.extendedShapeCoverage)
        XCTAssertNil(Self.partial1Font?.math?.glyphInfo?.extendedShapeCoverage)

        guard let extendedShapes = Self.fullFont?.math?.glyphInfo?.extendedShapeCoverage
        else {
            XCTFail("Extended shapes not found")
            return
        }

        var glyphId: UInt16

        // G, H

        glyphId = Self.fullCTFont!.getGlyphWithName("G")
        XCTAssertFalse(extendedShapes.contains(glyphId))

        glyphId = Self.fullCTFont!.getGlyphWithName("H")
        XCTAssertTrue(extendedShapes.contains(glyphId))
    }

    func testKernInfo() {
    }

    func testMoreKernInfo() {
    }

    func testGlyphVariants() {
        XCTAssertNil(Self.emptyFont?.math?.variants)

        for item in [Self.partial1Font, Self.partial2Font] {
            guard let variants = item?.math?.variants
            else {
                XCTFail("Variants not found")
                continue
            }

            let glyphId = Self.partial1CTFont!.getGlyphWithName("space")

            XCTAssertNil(variants.horizGlyphConstructions?[glyphId]?.glyphVariants.count)
            XCTAssertNil(variants.vertGlyphConstructions?[glyphId]?.glyphVariants.count)
        }

        do {
            guard let variants = Self.partial3Font?.math?.variants
            else {
                XCTFail("Variants not found")
                return
            }

            let glyphId = Self.partial3CTFont!.getGlyphWithName("space")

            XCTAssertEqual(variants.horizGlyphConstructions?[glyphId]?.glyphVariants.count, 0)
            XCTAssertEqual(variants.vertGlyphConstructions?[glyphId]?.glyphVariants.count, 0)
        }

        do {
            guard let variants = Self.fullFont?.math?.variants
            else {
                XCTFail("Variants not found")
                return
            }

            var glyphId: UInt16

            // variants count
            glyphId = Self.fullCTFont!.getGlyphWithName("arrowleft")
            XCTAssertEqual(variants.horizGlyphConstructions?[glyphId]?.glyphVariants.count, 3)
            XCTAssertEqual(variants.vertGlyphConstructions?[glyphId]?.glyphVariants.count, nil)

            //
            glyphId = Self.fullCTFont!.getGlyphWithName("arrowup")
            XCTAssertEqual(variants.horizGlyphConstructions?[glyphId]?.glyphVariants.count, nil)
            XCTAssertEqual(variants.vertGlyphConstructions?[glyphId]?.glyphVariants.count, 4)

            //
            glyphId = Self.fullCTFont!.getGlyphWithName("arrowleft")
            do {
                let variants = variants.horizGlyphConstructions![glyphId]!.glyphVariants
                XCTAssertEqual(variants.count, 3)

                XCTAssertEqual(variants[0]?.variantGlyph, Self.fullCTFont?.getGlyphWithName("uni2190_size2"))
                XCTAssertEqual(variants[1]?.variantGlyph, Self.fullCTFont?.getGlyphWithName("uni2190_size3"))
                XCTAssertEqual(variants[2]?.variantGlyph, Self.fullCTFont?.getGlyphWithName("uni2190_size4"))

                XCTAssertEqual(variants[0]?.advanceMeasurement, 2151)
                XCTAssertEqual(variants[1]?.advanceMeasurement, 2401)
                XCTAssertEqual(variants[2]?.advanceMeasurement, 2901)
            }

            glyphId = Self.fullCTFont!.getGlyphWithName("arrowup")
            do {
                let variants = variants.vertGlyphConstructions![glyphId]!.glyphVariants
                XCTAssertEqual(variants.count, 4)

                XCTAssertEqual(variants[0]?.variantGlyph, Self.fullCTFont?.getGlyphWithName("uni2191_size2"))
                XCTAssertEqual(variants[1]?.variantGlyph, Self.fullCTFont?.getGlyphWithName("uni2191_size3"))
                XCTAssertEqual(variants[2]?.variantGlyph, Self.fullCTFont?.getGlyphWithName("uni2191_size4"))
                XCTAssertEqual(variants[3]?.variantGlyph, Self.fullCTFont?.getGlyphWithName("uni2191_size5"))

                XCTAssertEqual(variants[0]?.advanceMeasurement, 2251)
                XCTAssertEqual(variants[1]?.advanceMeasurement, 2501)
                XCTAssertEqual(variants[2]?.advanceMeasurement, 3001)
                XCTAssertEqual(variants[3]?.advanceMeasurement, 3751)
            }
        }
    }

    func testMinConnectorOverlap() {
        XCTAssertNil(Self.emptyFont?.math?.variants?.minConnectorOverlap)

        XCTAssertEqual(Self.partial1Font?.math?.variants?.minConnectorOverlap, 54)
    }

    func testGlyphAssembly() {
        XCTAssertNil(Self.emptyFont?.math?.variants)

        for (font, ctFont) in [
            (Self.partial1Font, Self.partial1CTFont),
            (Self.partial2Font, Self.partial2CTFont),
            (Self.partial3Font, Self.partial3CTFont),
        ] {
            guard let variants = font?.math?.variants else {
                XCTFail("Variants not found")
                return
            }

            let glyphId = ctFont!.getGlyphWithName("space")

            XCTAssertNil(variants.horizGlyphConstructions?[glyphId]?.glyphAssembly)
            XCTAssertNil(variants.vertGlyphConstructions?[glyphId]?.glyphAssembly)
        }

        for (font, ctFont) in [
            (Self.partial4Font, Self.partial4CTFont),
        ] {
            guard let variants = font?.math?.variants else {
                XCTFail("Variants not found")
                return
            }

            let glyphId = ctFont!.getGlyphWithName("space")

            XCTAssertEqual(variants.horizGlyphConstructions?[glyphId]?.glyphAssembly?.partCount, 0)
            XCTAssertEqual(variants.vertGlyphConstructions?[glyphId]?.glyphAssembly?.partCount, 0)

            AssertEqual(variants.horizGlyphConstructions?[glyphId]?.glyphAssembly?.italicsCorrection, 0)
            AssertEqual(variants.vertGlyphConstructions?[glyphId]?.glyphAssembly?.italicsCorrection, 0)
        }
    }

    // MARK: - Helper

    func AssertEqual(_ actual: MathValueRecord, _ expected: Int16) {
        XCTAssertEqual(actual.value, expected)
    }

    func AssertEqual(_ actual: MathValueRecord?, _ expected: Int16) {
        XCTAssertEqual(actual?.value, expected)
    }

    func AssertEqual(_ actual: MathValue, _ expected: Int16) {
        XCTAssertEqual(actual.value, expected)
    }
}
