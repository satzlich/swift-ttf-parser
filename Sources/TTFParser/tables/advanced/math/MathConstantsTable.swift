// Copyright 2024 Lie Yan

// MARK: - MathConstantsTable

public struct MathConstantsTable: SafeDecodable {
    public var scriptPercentScaleDown: Int16 {
        Int16.decode(self.baseAddress + _Offsets.scriptPercentScaleDown)
    }

    public var scriptScriptPercentScaleDown: Int16 {
        Int16.decode(self.baseAddress + _Offsets.scriptScriptPercentScaleDown)
    }

    public var delimitedSubFormulaMinHeight: UFWORD {
        UFWORD.decode(self.baseAddress + _Offsets.delimitedSubFormulaMinHeight)
    }

    public var displayOperatorMinHeight: UFWORD {
        UFWORD.decode(self.baseAddress + _Offsets.displayOperatorMinHeight)
    }

    public var mathLeading: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.mathLeading)
    }

    public var axisHeight: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.axisHeight)
    }

    public var accentBaseHeight: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.accentBaseHeight)
    }

    public var flattenedAccentBaseHeight: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.flattenedAccentBaseHeight)
    }

    public var subscriptShiftDown: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.subscriptShiftDown)
    }

    public var subscriptTopMax: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.subscriptTopMax)
    }

    public var subscriptBaselineDropMin: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.subscriptBaselineDropMin)
    }

    public var superscriptShiftUp: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.superscriptShiftUp)
    }

    public var superscriptShiftUpCramped: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.superscriptShiftUpCramped)
    }

    public var superscriptBottomMin: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.superscriptBottomMin)
    }

    public var superscriptBaselineDropMax: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.superscriptBaselineDropMax)
    }

    public var subSuperscriptGapMin: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.subSuperscriptGapMin)
    }

    public var superscriptBottomMaxWithSubscript: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.superscriptBottomMaxWithSubscript)
    }

    public var spaceAfterScript: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.spaceAfterScript)
    }

    public var upperLimitGapMin: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.upperLimitGapMin)
    }

    public var upperLimitBaselineRiseMin: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.upperLimitBaselineRiseMin)
    }

    public var lowerLimitGapMin: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.lowerLimitGapMin)
    }

    public var lowerLimitBaselineDropMin: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.lowerLimitBaselineDropMin)
    }

    public var stackTopShiftUp: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.stackTopShiftUp)
    }

    public var stackTopDisplayStyleShiftUp: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.stackTopDisplayStyleShiftUp)
    }

    public var stackBottomShiftDown: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.stackBottomShiftDown)
    }

    public var stackBottomDisplayStyleShiftDown: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.stackBottomDisplayStyleShiftDown)
    }

    public var stackGapMin: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.stackGapMin)
    }

    public var stackDisplayStyleGapMin: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.stackDisplayStyleGapMin)
    }

    public var stretchStackTopShiftUp: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.stretchStackTopShiftUp)
    }

    public var stretchStackBottomShiftDown: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.stretchStackBottomShiftDown)
    }

    public var stretchStackGapAboveMin: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.stretchStackGapAboveMin)
    }

    public var stretchStackGapBelowMin: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.stretchStackGapBelowMin)
    }

    public var fractionNumeratorShiftUp: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.fractionNumeratorShiftUp)
    }

    public var fractionNumeratorDisplayStyleShiftUp: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.fractionNumeratorDisplayStyleShiftUp)
    }

    public var fractionDenominatorShiftDown: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.fractionDenominatorShiftDown)
    }

    public var fractionDenominatorDisplayStyleShiftDown: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.fractionDenominatorDisplayStyleShiftDown)
    }

    public var fractionNumeratorGapMin: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.fractionNumeratorGapMin)
    }

    public var fractionNumDisplayStyleGapMin: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.fractionNumDisplayStyleGapMin)
    }

    public var fractionRuleThickness: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.fractionRuleThickness)
    }

    public var fractionDenominatorGapMin: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.fractionDenominatorGapMin)
    }

    public var fractionDenomDisplayStyleGapMin: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.fractionDenomDisplayStyleGapMin)
    }

    public var skewedFractionHorizontalGap: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.skewedFractionHorizontalGap)
    }

    public var skewedFractionVerticalGap: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.skewedFractionVerticalGap)
    }

    public var overbarVerticalGap: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.overbarVerticalGap)
    }

    public var overbarRuleThickness: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.overbarRuleThickness)
    }

    public var overbarExtraAscender: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.overbarExtraAscender)
    }

    public var underbarVerticalGap: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.underbarVerticalGap)
    }

    public var underbarRuleThickness: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.underbarRuleThickness)
    }

    public var underbarExtraDescender: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.underbarExtraDescender)
    }

    public var radicalVerticalGap: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.radicalVerticalGap)
    }

    public var radicalDisplayStyleVerticalGap: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.radicalDisplayStyleVerticalGap)
    }

    public var radicalRuleThickness: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.radicalRuleThickness)
    }

    public var radicalExtraAscender: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.radicalExtraAscender)
    }

    public var radicalKernBeforeDegree: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.radicalKernBeforeDegree)
    }

    public var radicalKernAfterDegree: MathValueRecord {
        MathValueRecord.decode(self.baseAddress + _Offsets.radicalKernAfterDegree)
    }

    public var radicalDegreeBottomRaisePercent: Int16 {
        Int16.decode(self.baseAddress + _Offsets.radicalDegreeBottomRaisePercent)
    }

    private enum _Offsets {
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

    private let bytes: UnsafeBufferPointer<UInt8>
    private let baseAddress: UnsafePointer<UInt8>

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        self.bytes = bytes
        // store baseAddress for efficiency
        self.baseAddress = bytes.baseAddress!
    }

    public static let minWidth
        = _Offsets.radicalDegreeBottomRaisePercent + Int16.encodingWidth

    public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathConstantsTable? {
        MathConstantsTable(bytes)
    }
}
