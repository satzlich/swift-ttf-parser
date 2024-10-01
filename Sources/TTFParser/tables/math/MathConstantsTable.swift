// Copyright 2024 Lie Yan

enum MathConstantsTable {
    // MARK: - Properties

    // MARK: - Offsets

    private enum Offsets {
        static let scriptPercentScaleDown = 0
        static let scriptScriptPercentScaleDown = scriptPercentScaleDown + Int16.encodingWidth
        static let delimitedSubFormulaMinHeight = scriptScriptPercentScaleDown + Int16.encodingWidth
        static let displayOperatorMinHeight = delimitedSubFormulaMinHeight + UFWORD.encodingWidth
        static let mathLeading = displayOperatorMinHeight + UFWORD.encodingWidth
        static let axisHeight = mathLeading + MathValueRecord.encodingWidth
        static let accentBaseHeight = axisHeight + MathValueRecord.encodingWidth
        static let flattenedAccentBaseHeight = accentBaseHeight + MathValueRecord.encodingWidth
        static let subscriptShiftDown = flattenedAccentBaseHeight + MathValueRecord.encodingWidth
        static let subscriptTopMax = subscriptShiftDown + MathValueRecord.encodingWidth
        static let subscriptBaselineDropMin = subscriptTopMax + MathValueRecord.encodingWidth
        static let superscriptShiftUp = subscriptBaselineDropMin + MathValueRecord.encodingWidth
        static let superscriptShiftUpCramped = superscriptShiftUp + MathValueRecord.encodingWidth
        static let superscriptBottomMin = superscriptShiftUpCramped + MathValueRecord.encodingWidth
        static let superscriptBaselineDropMax = superscriptBottomMin + MathValueRecord.encodingWidth
        static let subSuperscriptGapMin = superscriptBaselineDropMax + MathValueRecord.encodingWidth
        static let superscriptBottomMaxWithSubscript = subSuperscriptGapMin + MathValueRecord.encodingWidth
        static let spaceAfterScript = superscriptBottomMaxWithSubscript + MathValueRecord.encodingWidth
        static let upperLimitGapMin = spaceAfterScript + MathValueRecord.encodingWidth
        static let upperLimitBaselineRiseMin = upperLimitGapMin + MathValueRecord.encodingWidth
        static let lowerLimitGapMin = upperLimitBaselineRiseMin + MathValueRecord.encodingWidth
        static let lowerLimitBaselineDropMin = lowerLimitGapMin + MathValueRecord.encodingWidth
        static let stackTopShiftUp = lowerLimitBaselineDropMin + MathValueRecord.encodingWidth
        static let stackTopDisplayStyleShiftUp = stackTopShiftUp + MathValueRecord.encodingWidth
        static let stackBottomShiftDown = stackTopDisplayStyleShiftUp + MathValueRecord.encodingWidth
        static let stackBottomDisplayStyleShiftDown = stackBottomShiftDown + MathValueRecord.encodingWidth
        static let stackGapMin = stackBottomDisplayStyleShiftDown + MathValueRecord.encodingWidth
        static let stackDisplayStyleGapMin = stackGapMin + MathValueRecord.encodingWidth
        static let stretchStackTopShiftUp = stackDisplayStyleGapMin + MathValueRecord.encodingWidth
        static let stretchStackBottomShiftDown = stretchStackTopShiftUp + MathValueRecord.encodingWidth
        static let stretchStackGapAboveMin = stretchStackBottomShiftDown + MathValueRecord.encodingWidth
        static let stretchStackGapBelowMin = stretchStackGapAboveMin + MathValueRecord.encodingWidth
        static let fractionNumeratorShiftUp = stretchStackGapBelowMin + MathValueRecord.encodingWidth
        static let fractionNumeratorDisplayStyleShiftUp = fractionNumeratorShiftUp + MathValueRecord.encodingWidth
        static let fractionDenominatorShiftDown = fractionNumeratorDisplayStyleShiftUp + MathValueRecord.encodingWidth
        static let fractionDenominatorDisplayStyleShiftDown =
            fractionDenominatorShiftDown + MathValueRecord.encodingWidth
        static let fractionNumeratorGapMin = fractionDenominatorDisplayStyleShiftDown + MathValueRecord.encodingWidth
        static let fractionNumDisplayStyleGapMin = fractionNumeratorGapMin + MathValueRecord.encodingWidth
        static let fractionRuleThickness = fractionNumDisplayStyleGapMin + MathValueRecord.encodingWidth
        static let fractionDenominatorGapMin = fractionRuleThickness + MathValueRecord.encodingWidth
        static let fractionDenomDisplayStyleGapMin = fractionDenominatorGapMin + MathValueRecord.encodingWidth
        static let skewedFractionHorizontalGap = fractionDenomDisplayStyleGapMin + MathValueRecord.encodingWidth
        static let skewedFractionVerticalGap = skewedFractionHorizontalGap + MathValueRecord.encodingWidth
        static let overbarVerticalGap = skewedFractionVerticalGap + MathValueRecord.encodingWidth
        static let overbarRuleThickness = overbarVerticalGap + MathValueRecord.encodingWidth
        static let overbarExtraAscender = overbarRuleThickness + MathValueRecord.encodingWidth
        static let underbarVerticalGap = overbarExtraAscender + MathValueRecord.encodingWidth
        static let underbarRuleThickness = underbarVerticalGap + MathValueRecord.encodingWidth
        static let underbarExtraDescender = underbarRuleThickness + MathValueRecord.encodingWidth
        static let radicalVerticalGap = underbarExtraDescender + MathValueRecord.encodingWidth
        static let radicalDisplayStyleVerticalGap = radicalVerticalGap + MathValueRecord.encodingWidth
        static let radicalRuleThickness = radicalDisplayStyleVerticalGap + MathValueRecord.encodingWidth
        static let radicalExtraAscender = radicalRuleThickness + MathValueRecord.encodingWidth
        static let radicalKernBeforeDegree = radicalExtraAscender + MathValueRecord.encodingWidth
        static let radicalKernAfterDegree = radicalKernBeforeDegree + MathValueRecord.encodingWidth
        static let radicalDegreeBottomRaisePercent = radicalKernAfterDegree + MathValueRecord.encodingWidth
    }
}
