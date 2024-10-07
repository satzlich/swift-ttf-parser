// Copyright 2024 Lie Yan

@testable import TTFParser
import Foundation
import XCTest

final class MathTableTests: XCTestCase {
    static var dataArray: [Data] = []
    static var fonts: [Font] = []
    static var ctFonts: [CTFont] = []

    var emptyFont: Font!
    var partial1Font: Font!
    var partial2Font: Font!
    var partial3Font: Font!
    var partial4Font: Font!
    var fullFont: Font!

    var emptyCTFont: CTFont!
    var partial1CTFont: CTFont!
    var partial2CTFont: CTFont!
    var partial3CTFont: CTFont!
    var partial4CTFont: CTFont!
    var fullCTFont: CTFont!

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

        guard fonts.count == list.count
        else {
            fatalError("Failed to load fonts")
        }

        dataArray = fonts.map { $0.data }
        Self.fonts = fonts.map { $0.font }

        // Load CTFonts

        ctFonts = list.compactMap {
            FontUtils.loadCTFont(forResource: $0,
                                 withExtension: "otf",
                                 subdirectory: "fonts")
        }

        guard ctFonts.count == list.count
        else {
            fatalError("Failed to load fonts")
        }
    }

    override func setUp() {
        emptyFont = Self.fonts[0]
        partial1Font = Self.fonts[1]
        partial2Font = Self.fonts[2]
        partial3Font = Self.fonts[3]
        partial4Font = Self.fonts[4]
        fullFont = Self.fonts[5]

        emptyCTFont = Self.ctFonts[0]
        partial1CTFont = Self.ctFonts[1]
        partial2CTFont = Self.ctFonts[2]
        partial3CTFont = Self.ctFonts[3]
        partial4CTFont = Self.ctFonts[4]
        fullCTFont = Self.ctFonts[5]
    }

    // MARK: - Tests

    func testConstants() {
        XCTAssertNil(emptyFont.math?.constants)

        guard let constants = fullFont.math?.constants
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
        XCTAssertNil(emptyFont.math?.glyphInfo?.italicsCorrections)
        XCTAssertNil(partial1Font.math?.glyphInfo?.italicsCorrections)
        XCTAssertNil(partial2Font.math?.glyphInfo?.italicsCorrections)

        do {
            guard let italicsCorrectionInfo = fullFont.math?.glyphInfo?.italicsCorrections
            else {
                XCTFail("Italics correction info not found")
                return
            }

            var glyphId: UInt16

            glyphId = fullCTFont.getGlyphWithName("space")
            XCTAssertNil(italicsCorrectionInfo[glyphId])

            glyphId = fullCTFont.getGlyphWithName("A")
            AssertEqual(italicsCorrectionInfo[glyphId]!, 197)

            glyphId = fullCTFont.getGlyphWithName("B")
            AssertEqual(italicsCorrectionInfo[glyphId]!, 150)

            glyphId = fullCTFont.getGlyphWithName("C")
            AssertEqual(italicsCorrectionInfo[glyphId]!, 452)
        }
    }

    func testTopAccentAttachment() {
        XCTAssertNil(emptyFont.math?.glyphInfo?.topAccentAttachments)
        XCTAssertNil(partial1Font.math?.glyphInfo?.topAccentAttachments)
        XCTAssertNil(partial2Font.math?.glyphInfo?.topAccentAttachments)

        do {
            guard let topAccentAttachment = fullFont.math?.glyphInfo?.topAccentAttachments
            else {
                XCTFail("Top accent attachment not found")
                return
            }

            var glyphId: UInt16

            // space, D, E, F

            glyphId = fullCTFont.getGlyphWithName("space")
            XCTAssertNil(topAccentAttachment[glyphId])

            glyphId = fullCTFont.getGlyphWithName("D")
            AssertEqual(topAccentAttachment[glyphId]!, 374)

            glyphId = fullCTFont.getGlyphWithName("E")
            AssertEqual(topAccentAttachment[glyphId]!, 346)

            glyphId = fullCTFont.getGlyphWithName("F")
            AssertEqual(topAccentAttachment[glyphId]!, 318)
        }
    }

    func testExtendedShapes() {
        XCTAssertNil(emptyFont.math?.glyphInfo?.extendedShapeCoverage)
        XCTAssertNil(partial1Font.math?.glyphInfo?.extendedShapeCoverage)

        guard let extendedShapes = fullFont.math?.glyphInfo?.extendedShapeCoverage
        else {
            XCTFail("Extended shapes not found")
            return
        }

        var glyphId: UInt16

        // G, H

        glyphId = fullCTFont.getGlyphWithName("G")
        XCTAssertFalse(extendedShapes.contains(glyphId))

        glyphId = fullCTFont.getGlyphWithName("H")
        XCTAssertTrue(extendedShapes.contains(glyphId))
    }

    func testKernInfo() {
        XCTAssertNil(emptyFont.math?.glyphInfo?.kerns)
        XCTAssertNil(partial2Font.math?.glyphInfo?.kerns)

        do {
            guard let kerns = partial3Font.math?.glyphInfo?.kerns
            else {
                XCTFail("Kerns not found")
                return
            }

            let glyphId = partial3CTFont.getGlyphWithName("space")

            XCTAssertNil(kerns.get(glyphId)?.topLeftMathKern)
            XCTAssertNil(kerns.get(glyphId)?.topLeftMathKern)
            XCTAssertNil(kerns.get(glyphId)?.bottomRightMathKern)
            XCTAssertNil(kerns.get(glyphId)?.bottomLeftMathKern)
        }

        do {
            guard let kerns = fullFont.math?.glyphInfo?.kerns
            else {
                XCTFail("Kerns not found")
                return
            }

            let glyphId = fullCTFont.getGlyphWithName("I")

            XCTAssertEqual(kerns.get(glyphId)?.topRightMathKern?.heightCount, 9)
            XCTAssertEqual(kerns.get(glyphId)?.topLeftMathKern?.heightCount, 2)
            XCTAssertEqual(kerns.get(glyphId)?.bottomRightMathKern?.heightCount, 8)
            XCTAssertEqual(kerns.get(glyphId)?.bottomLeftMathKern?.heightCount, 6)

            // case 1
            do {
                guard let kern = kerns.get(glyphId)?.topRightMathKern
                else {
                    XCTFail("Kern not found")
                    return
                }

                XCTAssertEqual(kern.heightCount, 9)
                // 14, 23, 32, 41, 50, 59, 68, 77, 86
                AssertEqual(kern.correctionHeights.get(0), 14)
                AssertEqual(kern.correctionHeights.get(1), 23)
                AssertEqual(kern.correctionHeights.get(2), 32)
                AssertEqual(kern.correctionHeights.get(3), 41)
                AssertEqual(kern.correctionHeights.get(4), 50)
                AssertEqual(kern.correctionHeights.get(5), 59)
                AssertEqual(kern.correctionHeights.get(6), 68)
                AssertEqual(kern.correctionHeights.get(7), 77)
                AssertEqual(kern.correctionHeights.get(8), 86)

                // 31, 52, 73, 94, 115, 136, 157, 178, 199, 220
                AssertEqual(kern.kernValues.get(0), 31)
                AssertEqual(kern.kernValues.get(1), 52)
                AssertEqual(kern.kernValues.get(2), 73)
                AssertEqual(kern.kernValues.get(3), 94)
                AssertEqual(kern.kernValues.get(4), 115)
                AssertEqual(kern.kernValues.get(5), 136)
                AssertEqual(kern.kernValues.get(6), 157)
                AssertEqual(kern.kernValues.get(7), 178)
                AssertEqual(kern.kernValues.get(8), 199)
                AssertEqual(kern.kernValues.get(9), 220)
            }

            // case 2
            do {
                guard let kern = kerns.get(glyphId)?.topLeftMathKern
                else {
                    XCTFail("Kern not found")
                    return
                }

                XCTAssertEqual(kern.heightCount, 2)
                // 20, 35
                AssertEqual(kern.correctionHeights.get(0), 20)
                AssertEqual(kern.correctionHeights.get(1), 35)

                // 25, 40, 55
                AssertEqual(kern.kernValues.get(0), 25)
                AssertEqual(kern.kernValues.get(1), 40)
                AssertEqual(kern.kernValues.get(2), 55)
            }
        }
    }

    func testMoreKernInfo() {
    }

    func testGlyphVariants() {
        XCTAssertNil(emptyFont.math?.variants)

        for item in [partial1Font, partial2Font] {
            guard let variants = item?.math?.variants
            else {
                XCTFail("Variants not found")
                continue
            }

            let glyphId = partial1CTFont.getGlyphWithName("space")

            XCTAssertNil(variants.horizGlyphConstructions?.get(glyphId)?.glyphVariants.count)
            XCTAssertNil(variants.vertGlyphConstructions?.get(glyphId)?.glyphVariants.count)
        }

        do {
            guard let variants = partial3Font.math?.variants
            else {
                XCTFail("Variants not found")
                return
            }

            let glyphId = partial3CTFont.getGlyphWithName("space")

            XCTAssertEqual(variants.horizGlyphConstructions?.get(glyphId)?.glyphVariants.count, 0)
            XCTAssertEqual(variants.vertGlyphConstructions?.get(glyphId)?.glyphVariants.count, 0)
        }

        do {
            guard let variants = fullFont.math?.variants
            else {
                XCTFail("Variants not found")
                return
            }

            var glyphId: UInt16

            // variants count
            glyphId = fullCTFont.getGlyphWithName("arrowleft")
            XCTAssertEqual(variants.horizGlyphConstructions?.get(glyphId)?.glyphVariants.count, 3)
            XCTAssertEqual(variants.vertGlyphConstructions?.get(glyphId)?.glyphVariants.count, nil)

            //
            glyphId = fullCTFont.getGlyphWithName("arrowup")
            XCTAssertEqual(variants.horizGlyphConstructions?.get(glyphId)?.glyphVariants.count, nil)
            XCTAssertEqual(variants.vertGlyphConstructions?.get(glyphId)?.glyphVariants.count, 4)

            //
            glyphId = fullCTFont.getGlyphWithName("arrowleft")
            do {
                let variants = variants.horizGlyphConstructions!.get(glyphId)!.glyphVariants
                XCTAssertEqual(variants.count, 3)

                XCTAssertEqual(variants.get(0)?.variantGlyph, fullCTFont.getGlyphWithName("uni2190_size2"))
                XCTAssertEqual(variants.get(1)?.variantGlyph, fullCTFont.getGlyphWithName("uni2190_size3"))
                XCTAssertEqual(variants.get(2)?.variantGlyph, fullCTFont.getGlyphWithName("uni2190_size4"))

                XCTAssertEqual(variants.get(0)?.advanceMeasurement, 2151)
                XCTAssertEqual(variants.get(1)?.advanceMeasurement, 2401)
                XCTAssertEqual(variants.get(2)?.advanceMeasurement, 2901)
            }

            glyphId = fullCTFont.getGlyphWithName("arrowup")
            do {
                let variants = variants.vertGlyphConstructions!.get(glyphId)!.glyphVariants
                XCTAssertEqual(variants.count, 4)

                XCTAssertEqual(variants.get(0)?.variantGlyph, fullCTFont.getGlyphWithName("uni2191_size2"))
                XCTAssertEqual(variants.get(1)?.variantGlyph, fullCTFont.getGlyphWithName("uni2191_size3"))
                XCTAssertEqual(variants.get(2)?.variantGlyph, fullCTFont.getGlyphWithName("uni2191_size4"))
                XCTAssertEqual(variants.get(3)?.variantGlyph, fullCTFont.getGlyphWithName("uni2191_size5"))

                XCTAssertEqual(variants.get(0)?.advanceMeasurement, 2251)
                XCTAssertEqual(variants.get(1)?.advanceMeasurement, 2501)
                XCTAssertEqual(variants.get(2)?.advanceMeasurement, 3001)
                XCTAssertEqual(variants.get(3)?.advanceMeasurement, 3751)
            }
        }
    }

    func testMinConnectorOverlap() {
        XCTAssertNil(emptyFont.math?.variants?.minConnectorOverlap)

        XCTAssertEqual(partial1Font.math?.variants?.minConnectorOverlap, 54)
    }

    func testGlyphAssembly() {
        XCTAssertNil(emptyFont.math?.variants)

        for (font, ctFont) in [
            (partial1Font!, partial1CTFont!),
            (partial2Font!, partial2CTFont!),
            (partial3Font!, partial3CTFont!),
        ] {
            guard let variants = font.math?.variants else {
                XCTFail("Variants not found")
                return
            }

            let glyphId = ctFont.getGlyphWithName("space")

            XCTAssertNil(variants.horizGlyphConstructions?.get(glyphId)?.glyphAssembly)
            XCTAssertNil(variants.vertGlyphConstructions?.get(glyphId)?.glyphAssembly)
        }

        for (font, ctFont) in [
            (partial4Font!, partial4CTFont!),
        ] {
            guard let variants = font.math?.variants else {
                XCTFail("Variants not found")
                return
            }

            let glyphId = ctFont.getGlyphWithName("space")

            XCTAssertEqual(variants.horizGlyphConstructions?.get(glyphId)?.glyphAssembly?.partCount, 0)
            XCTAssertEqual(variants.vertGlyphConstructions?.get(glyphId)?.glyphAssembly?.partCount, 0)

            AssertEqual(variants.horizGlyphConstructions?.get(glyphId)?.glyphAssembly?.italicsCorrection, 0)
            AssertEqual(variants.vertGlyphConstructions?.get(glyphId)?.glyphAssembly?.italicsCorrection, 0)
        }

        guard let variants = fullFont.math?.variants
        else {
            XCTFail("Variants not found")
            return
        }

        var glyphId: UInt16

        // italics correction
        glyphId = fullCTFont.getGlyphWithName("arrowleft")
        AssertEqual(variants.horizGlyphConstructions?.get(glyphId)?.glyphAssembly?.italicsCorrection, 124)
        XCTAssertNil(variants.vertGlyphConstructions?.get(glyphId)?.glyphAssembly?.italicsCorrection)

        glyphId = fullCTFont.getGlyphWithName("arrowup")
        XCTAssertNil(variants.horizGlyphConstructions?.get(glyphId)?.glyphAssembly?.italicsCorrection)
        AssertEqual(variants.vertGlyphConstructions?.get(glyphId)?.glyphAssembly?.italicsCorrection, 331)

        // part count
        glyphId = fullCTFont.getGlyphWithName("arrowright")
        XCTAssertEqual(variants.horizGlyphConstructions?.get(glyphId)?.glyphAssembly?.partCount, 3)
        XCTAssertNil(variants.vertGlyphConstructions?.get(glyphId)?.glyphAssembly?.partCount)

        glyphId = fullCTFont.getGlyphWithName("arrowdown")
        XCTAssertNil(variants.horizGlyphConstructions?.get(glyphId)?.glyphAssembly?.partCount)
        XCTAssertEqual(variants.vertGlyphConstructions?.get(glyphId)?.glyphAssembly?.partCount, 5)

        // details
        do {
            glyphId = fullCTFont.getGlyphWithName("arrowright")

            guard let assembly = variants.horizGlyphConstructions?.get(glyphId)?.glyphAssembly
            else {
                XCTFail("Glyph assembly not found")
                return
            }
            let parts = assembly.partRecords

            // count = 3
            XCTAssertEqual(parts.count, 3)

            // part 0
            XCTAssertEqual(parts.get(0)?.glyphID, fullCTFont.getGlyphWithName("left"))
            XCTAssertEqual(parts.get(0)?.startConnectorLength, 400)
            XCTAssertEqual(parts.get(0)?.endConnectorLength, 192)
            XCTAssertEqual(parts.get(0)?.fullAdvance, 1000)
            XCTAssertEqual(parts.get(0)?.isExtender(), false)

            // part 1
            XCTAssertEqual(parts.get(1)?.glyphID, fullCTFont.getGlyphWithName("horizontal"))
            XCTAssertEqual(parts.get(1)?.startConnectorLength, 262)
            XCTAssertEqual(parts.get(1)?.endConnectorLength, 400)
            XCTAssertEqual(parts.get(1)?.fullAdvance, 1000)
            XCTAssertEqual(parts.get(1)?.isExtender(), true)

            // part 2
            XCTAssertEqual(parts.get(2)?.glyphID, fullCTFont.getGlyphWithName("right"))
            XCTAssertEqual(parts.get(2)?.startConnectorLength, 158)
            XCTAssertEqual(parts.get(2)?.endConnectorLength, 227)
            XCTAssertEqual(parts.get(2)?.fullAdvance, 1000)
            XCTAssertEqual(parts.get(2)?.isExtender(), false)

            // italics correction, 379
            AssertEqual(assembly.italicsCorrection, 379)
        }

        do {
            glyphId = fullCTFont.getGlyphWithName("arrowdown")

            guard let assembly = variants.vertGlyphConstructions?.get(glyphId)?.glyphAssembly
            else {
                XCTFail("Glyph assembly not found")
                return
            }
            let parts = assembly.partRecords

            // part 0, "bottom", 365, 158, 1000, false
            XCTAssertEqual(parts.get(0)?.glyphID, fullCTFont.getGlyphWithName("bottom"))
            XCTAssertEqual(parts.get(0)?.startConnectorLength, 365)
            XCTAssertEqual(parts.get(0)?.endConnectorLength, 158)
            XCTAssertEqual(parts.get(0)?.fullAdvance, 1000)
            XCTAssertEqual(parts.get(0)?.isExtender(), false)

            // part 1, "vertical", 227, 365, 1000, true
            XCTAssertEqual(parts.get(1)?.glyphID, fullCTFont.getGlyphWithName("vertical"))
            XCTAssertEqual(parts.get(1)?.startConnectorLength, 227)
            XCTAssertEqual(parts.get(1)?.endConnectorLength, 365)
            XCTAssertEqual(parts.get(1)?.fullAdvance, 1000)
            XCTAssertEqual(parts.get(1)?.isExtender(), true)

            // part 2, "center", 54, 158, 1000, false
            XCTAssertEqual(parts.get(2)?.glyphID, fullCTFont.getGlyphWithName("center"))
            XCTAssertEqual(parts.get(2)?.startConnectorLength, 54)
            XCTAssertEqual(parts.get(2)?.endConnectorLength, 158)
            XCTAssertEqual(parts.get(2)?.fullAdvance, 1000)
            XCTAssertEqual(parts.get(2)?.isExtender(), false)

            // part 3, "vertical", 400, 296, 1000, true
            XCTAssertEqual(parts.get(3)?.glyphID, fullCTFont.getGlyphWithName("vertical"))
            XCTAssertEqual(parts.get(3)?.startConnectorLength, 400)
            XCTAssertEqual(parts.get(3)?.endConnectorLength, 296)
            XCTAssertEqual(parts.get(3)?.fullAdvance, 1000)
            XCTAssertEqual(parts.get(3)?.isExtender(), true)

            // part 4, "top", 123, 192, 1000, false
            XCTAssertEqual(parts.get(4)?.glyphID, fullCTFont.getGlyphWithName("top"))
            XCTAssertEqual(parts.get(4)?.startConnectorLength, 123)
            XCTAssertEqual(parts.get(4)?.endConnectorLength, 192)
            XCTAssertEqual(parts.get(4)?.fullAdvance, 1000)
            XCTAssertEqual(parts.get(4)?.isExtender(), false)

            // italics correction
            AssertEqual(assembly.italicsCorrection, 237)
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
