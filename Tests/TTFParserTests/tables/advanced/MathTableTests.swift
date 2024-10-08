// Copyright 2024 Lie Yan

import Foundation
import TTFParser
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
        let list = [
            "MathTestFontEmpty",
            "MathTestFontPartial1",
            "MathTestFontPartial2",
            "MathTestFontPartial3",
            "MathTestFontPartial4",
            "MathTestFontFull",
        ]

        // Load fonts

        let fonts = list.compactMap {
            FontUtils.loadFont(forResource: $0,
                               withExtension: "otf",
                               subdirectory: "fonts")
        }

        guard fonts.count == list.count
        else {
            XCTFail("Failed to load fonts")
            return
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
            XCTFail("Failed to load fonts")
            return
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
            XCTAssertNil(italicsCorrectionInfo.get(glyphId))

            glyphId = fullCTFont.getGlyphWithName("A")
            AssertEqual(italicsCorrectionInfo.get(glyphId)!, 197)

            glyphId = fullCTFont.getGlyphWithName("B")
            AssertEqual(italicsCorrectionInfo.get(glyphId)!, 150)

            glyphId = fullCTFont.getGlyphWithName("C")
            AssertEqual(italicsCorrectionInfo.get(glyphId)!, 452)
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
            XCTAssertNil(topAccentAttachment.get(glyphId))

            glyphId = fullCTFont.getGlyphWithName("D")
            AssertEqual(topAccentAttachment.get(glyphId)!, 374)

            glyphId = fullCTFont.getGlyphWithName("E")
            AssertEqual(topAccentAttachment.get(glyphId)!, 346)

            glyphId = fullCTFont.getGlyphWithName("F")
            AssertEqual(topAccentAttachment.get(glyphId)!, 318)
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

            XCTAssertNil(kerns.get(glyphId)?.topLeft)
            XCTAssertNil(kerns.get(glyphId)?.topLeft)
            XCTAssertNil(kerns.get(glyphId)?.bottomRight)
            XCTAssertNil(kerns.get(glyphId)?.bottomLeft)
        }

        do {
            guard let kerns = fullFont.math?.glyphInfo?.kerns
            else {
                XCTFail("Kerns not found")
                return
            }

            let glyphId = fullCTFont.getGlyphWithName("I")

            XCTAssertEqual(kerns.get(glyphId)?.topRight?.heightCount, 9)
            XCTAssertEqual(kerns.get(glyphId)?.topLeft?.heightCount, 2)
            XCTAssertEqual(kerns.get(glyphId)?.bottomRight?.heightCount, 8)
            XCTAssertEqual(kerns.get(glyphId)?.bottomLeft?.heightCount, 6)

            // case 1
            do {
                guard let kern = kerns.get(glyphId)?.topRight
                else {
                    XCTFail("Kern not found")
                    return
                }

                XCTAssertEqual(kern.heightCount, 9)
                // 14, 23, 32, 41, 50, 59, 68, 77, 86
                AssertEqual(kern.correctionHeights.at(0), 14)
                AssertEqual(kern.correctionHeights.at(1), 23)
                AssertEqual(kern.correctionHeights.at(2), 32)
                AssertEqual(kern.correctionHeights.at(3), 41)
                AssertEqual(kern.correctionHeights.at(4), 50)
                AssertEqual(kern.correctionHeights.at(5), 59)
                AssertEqual(kern.correctionHeights.at(6), 68)
                AssertEqual(kern.correctionHeights.at(7), 77)
                AssertEqual(kern.correctionHeights.at(8), 86)

                // 31, 52, 73, 94, 115, 136, 157, 178, 199, 220
                AssertEqual(kern.kernValues.at(0), 31)
                AssertEqual(kern.kernValues.at(1), 52)
                AssertEqual(kern.kernValues.at(2), 73)
                AssertEqual(kern.kernValues.at(3), 94)
                AssertEqual(kern.kernValues.at(4), 115)
                AssertEqual(kern.kernValues.at(5), 136)
                AssertEqual(kern.kernValues.at(6), 157)
                AssertEqual(kern.kernValues.at(7), 178)
                AssertEqual(kern.kernValues.at(8), 199)
                AssertEqual(kern.kernValues.at(9), 220)
            }

            // case 2
            do {
                guard let kern = kerns.get(glyphId)?.topLeft
                else {
                    XCTFail("Kern not found")
                    return
                }

                XCTAssertEqual(kern.heightCount, 2)
                // 20, 35
                AssertEqual(kern.correctionHeights.at(0), 20)
                AssertEqual(kern.correctionHeights.at(1), 35)

                // 25, 40, 55
                AssertEqual(kern.kernValues.at(0), 25)
                AssertEqual(kern.kernValues.at(1), 40)
                AssertEqual(kern.kernValues.at(2), 55)
            }
        }
    }

    func testMoreKernInfo() {
        guard let kerns = fullFont.math?.glyphInfo?.kerns else {
            XCTFail("Kerns not found")
            return
        }

        let glyphId: UInt16 = fullCTFont.getGlyphWithName("I")

        do {
            let kern: MathKernTable! = kerns.get(glyphId)?.topRight

            XCTAssertEqual(kern.get(7), 31) // less than min height
            XCTAssertEqual(kern.get(14), 52) // equal to min height
            XCTAssertEqual(kern.get(20), 52)
            XCTAssertEqual(kern.get(23), 73)
            XCTAssertEqual(kern.get(31), 73)
            XCTAssertEqual(kern.get(32), 94)
            XCTAssertEqual(kern.get(86), 220) // equal to max height
            XCTAssertEqual(kern.get(91), 220) // larger than max height
            XCTAssertEqual(kern.get(96), 220) // larger than max height
        }

        do {
            let kernInfo: MathKernInfo! = kerns.get(glyphId)

            XCTAssertEqual(kernInfo.topRight?.get(39), 94)
            XCTAssertEqual(kernInfo.topLeft?.get(39), 55)
            XCTAssertEqual(kernInfo.bottomRight?.get(39), 22)
            XCTAssertEqual(kernInfo.bottomLeft?.get(39), 50)
        }
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

            XCTAssertNil(variants.horizontalConstructions?.get(glyphId)?.variants.count)
            XCTAssertNil(variants.verticalConstructions?.get(glyphId)?.variants.count)
        }

        do {
            guard let variants = partial3Font.math?.variants
            else {
                XCTFail("Variants not found")
                return
            }

            let glyphId = partial3CTFont.getGlyphWithName("space")

            XCTAssertEqual(variants.horizontalConstructions?.get(glyphId)?.variants.count, 0)
            XCTAssertEqual(variants.verticalConstructions?.get(glyphId)?.variants.count, 0)
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
            XCTAssertEqual(variants.horizontalConstructions?.get(glyphId)?.variants.count, 3)
            XCTAssertEqual(variants.verticalConstructions?.get(glyphId)?.variants.count, nil)

            //
            glyphId = fullCTFont.getGlyphWithName("arrowup")
            XCTAssertEqual(variants.horizontalConstructions?.get(glyphId)?.variants.count, nil)
            XCTAssertEqual(variants.verticalConstructions?.get(glyphId)?.variants.count, 4)

            //
            glyphId = fullCTFont.getGlyphWithName("arrowleft")
            do {
                let variants = variants.horizontalConstructions!.get(glyphId)!.variants
                XCTAssertEqual(variants.count, 3)

                XCTAssertEqual(variants.at(0)?.variantGlyph, fullCTFont.getGlyphWithName("uni2190_size2"))
                XCTAssertEqual(variants.at(1)?.variantGlyph, fullCTFont.getGlyphWithName("uni2190_size3"))
                XCTAssertEqual(variants.at(2)?.variantGlyph, fullCTFont.getGlyphWithName("uni2190_size4"))

                XCTAssertEqual(variants.at(0)?.advanceMeasurement, 2151)
                XCTAssertEqual(variants.at(1)?.advanceMeasurement, 2401)
                XCTAssertEqual(variants.at(2)?.advanceMeasurement, 2901)
            }

            glyphId = fullCTFont.getGlyphWithName("arrowup")
            do {
                let variants = variants.verticalConstructions!.get(glyphId)!.variants
                XCTAssertEqual(variants.count, 4)

                XCTAssertEqual(variants.at(0)?.variantGlyph, fullCTFont.getGlyphWithName("uni2191_size2"))
                XCTAssertEqual(variants.at(1)?.variantGlyph, fullCTFont.getGlyphWithName("uni2191_size3"))
                XCTAssertEqual(variants.at(2)?.variantGlyph, fullCTFont.getGlyphWithName("uni2191_size4"))
                XCTAssertEqual(variants.at(3)?.variantGlyph, fullCTFont.getGlyphWithName("uni2191_size5"))

                XCTAssertEqual(variants.at(0)?.advanceMeasurement, 2251)
                XCTAssertEqual(variants.at(1)?.advanceMeasurement, 2501)
                XCTAssertEqual(variants.at(2)?.advanceMeasurement, 3001)
                XCTAssertEqual(variants.at(3)?.advanceMeasurement, 3751)
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

            XCTAssertNil(variants.horizontalConstructions?.get(glyphId)?.assembly)
            XCTAssertNil(variants.verticalConstructions?.get(glyphId)?.assembly)
        }

        for (font, ctFont) in [
            (partial4Font!, partial4CTFont!),
        ] {
            guard let variants = font.math?.variants else {
                XCTFail("Variants not found")
                return
            }

            let glyphId = ctFont.getGlyphWithName("space")

            XCTAssertEqual(variants.horizontalConstructions?.get(glyphId)?.assembly?.parts.count, 0)
            XCTAssertEqual(variants.verticalConstructions?.get(glyphId)?.assembly?.parts.count, 0)

            AssertEqual(variants.horizontalConstructions?.get(glyphId)?.assembly?.italicsCorrection, 0)
            AssertEqual(variants.verticalConstructions?.get(glyphId)?.assembly?.italicsCorrection, 0)
        }

        guard let variants = fullFont.math?.variants
        else {
            XCTFail("Variants not found")
            return
        }

        var glyphId: UInt16

        // italics correction
        glyphId = fullCTFont.getGlyphWithName("arrowleft")
        AssertEqual(variants.horizontalConstructions?.get(glyphId)?.assembly?.italicsCorrection, 124)
        XCTAssertNil(variants.verticalConstructions?.get(glyphId)?.assembly?.italicsCorrection)

        glyphId = fullCTFont.getGlyphWithName("arrowup")
        XCTAssertNil(variants.horizontalConstructions?.get(glyphId)?.assembly?.italicsCorrection)
        AssertEqual(variants.verticalConstructions?.get(glyphId)?.assembly?.italicsCorrection, 331)

        // part count
        glyphId = fullCTFont.getGlyphWithName("arrowright")
        XCTAssertEqual(variants.horizontalConstructions?.get(glyphId)?.assembly?.parts.count, 3)
        XCTAssertNil(variants.verticalConstructions?.get(glyphId)?.assembly?.parts.count)

        glyphId = fullCTFont.getGlyphWithName("arrowdown")
        XCTAssertNil(variants.horizontalConstructions?.get(glyphId)?.assembly?.parts.count)
        XCTAssertEqual(variants.verticalConstructions?.get(glyphId)?.assembly?.parts.count, 5)

        // details
        do {
            glyphId = fullCTFont.getGlyphWithName("arrowright")

            guard let assembly = variants.horizontalConstructions?.get(glyphId)?.assembly
            else {
                XCTFail("Glyph assembly not found")
                return
            }
            let parts = assembly.parts

            // count = 3
            XCTAssertEqual(parts.count, 3)

            // part 0
            XCTAssertEqual(parts.at(0)?.glyphID, fullCTFont.getGlyphWithName("left"))
            XCTAssertEqual(parts.at(0)?.startConnectorLength, 400)
            XCTAssertEqual(parts.at(0)?.endConnectorLength, 192)
            XCTAssertEqual(parts.at(0)?.fullAdvance, 1000)
            XCTAssertEqual(parts.at(0)?.isExtender(), false)

            // part 1
            XCTAssertEqual(parts.at(1)?.glyphID, fullCTFont.getGlyphWithName("horizontal"))
            XCTAssertEqual(parts.at(1)?.startConnectorLength, 262)
            XCTAssertEqual(parts.at(1)?.endConnectorLength, 400)
            XCTAssertEqual(parts.at(1)?.fullAdvance, 1000)
            XCTAssertEqual(parts.at(1)?.isExtender(), true)

            // part 2
            XCTAssertEqual(parts.at(2)?.glyphID, fullCTFont.getGlyphWithName("right"))
            XCTAssertEqual(parts.at(2)?.startConnectorLength, 158)
            XCTAssertEqual(parts.at(2)?.endConnectorLength, 227)
            XCTAssertEqual(parts.at(2)?.fullAdvance, 1000)
            XCTAssertEqual(parts.at(2)?.isExtender(), false)

            // italics correction, 379
            AssertEqual(assembly.italicsCorrection, 379)
        }

        do {
            glyphId = fullCTFont.getGlyphWithName("arrowdown")

            guard let assembly = variants.verticalConstructions?.get(glyphId)?.assembly
            else {
                XCTFail("Glyph assembly not found")
                return
            }
            let parts = assembly.parts

            // part 0, "bottom", 365, 158, 1000, false
            XCTAssertEqual(parts.at(0)?.glyphID, fullCTFont.getGlyphWithName("bottom"))
            XCTAssertEqual(parts.at(0)?.startConnectorLength, 365)
            XCTAssertEqual(parts.at(0)?.endConnectorLength, 158)
            XCTAssertEqual(parts.at(0)?.fullAdvance, 1000)
            XCTAssertEqual(parts.at(0)?.isExtender(), false)

            // part 1, "vertical", 227, 365, 1000, true
            XCTAssertEqual(parts.at(1)?.glyphID, fullCTFont.getGlyphWithName("vertical"))
            XCTAssertEqual(parts.at(1)?.startConnectorLength, 227)
            XCTAssertEqual(parts.at(1)?.endConnectorLength, 365)
            XCTAssertEqual(parts.at(1)?.fullAdvance, 1000)
            XCTAssertEqual(parts.at(1)?.isExtender(), true)

            // part 2, "center", 54, 158, 1000, false
            XCTAssertEqual(parts.at(2)?.glyphID, fullCTFont.getGlyphWithName("center"))
            XCTAssertEqual(parts.at(2)?.startConnectorLength, 54)
            XCTAssertEqual(parts.at(2)?.endConnectorLength, 158)
            XCTAssertEqual(parts.at(2)?.fullAdvance, 1000)
            XCTAssertEqual(parts.at(2)?.isExtender(), false)

            // part 3, "vertical", 400, 296, 1000, true
            XCTAssertEqual(parts.at(3)?.glyphID, fullCTFont.getGlyphWithName("vertical"))
            XCTAssertEqual(parts.at(3)?.startConnectorLength, 400)
            XCTAssertEqual(parts.at(3)?.endConnectorLength, 296)
            XCTAssertEqual(parts.at(3)?.fullAdvance, 1000)
            XCTAssertEqual(parts.at(3)?.isExtender(), true)

            // part 4, "top", 123, 192, 1000, false
            XCTAssertEqual(parts.at(4)?.glyphID, fullCTFont.getGlyphWithName("top"))
            XCTAssertEqual(parts.at(4)?.startConnectorLength, 123)
            XCTAssertEqual(parts.at(4)?.endConnectorLength, 192)
            XCTAssertEqual(parts.at(4)?.fullAdvance, 1000)
            XCTAssertEqual(parts.at(4)?.isExtender(), false)

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
}
