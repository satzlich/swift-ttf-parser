
struct MathValueRecord {
    FWORD value;

    // @Field(DeviceTable deviceTable, parent)
    Offset16 deviceOffset;
}

struct DeviceTable {
    uint16 startSize;
    uint16 endSize;
    uint16 deltaFormat;

    // @Count((1 + (endSize - startSize)) >> (4 - deltaFormat))
    Array<uint16> deltaValue;
}

struct MathTable // for (majorVersion, minorVersion) == (1, 0) 
{
    uint16 majorVersion;
    uint16 minorVersion;

    // @Field(MathConstantsTable constants, this)
    Offset16 mathConstantsOffset; 

    // @Field(MathGlyphInfoTable glyphInfo, this)
    Offset16 mathGlyphInfoOffset;

    // @Field(MathVariantsTable variants, this)
    Offset16 mathVariantsOffset;  
}

struct MathConstantsTable {
    int16 scriptPercentScaleDown;
    int16 scriptScriptPercentScaleDown;
    UFWORD delimitedSubFormulaMinHeight;
    UFWORD displayOperatorMinHeight;
    MathValueRecord mathLeading;
    // ...
    // int16 radicalDegreeBottomRaisePercent;
}

struct MathItalicsCorrectionInfoTable {
    Offset16 italicsCorrectionCoverageOffset;
    uint16 italicsCorrectionCount;
    Array<MathValueRecord> italicsCorrections;
}

struct MathKernTable {
    uint16 heightCount;
    
    // @Count(heightCount)
    Array<MathValueRecord> correctionHeights;

    // @Count(heightCount + 1)
    Array<MathValueRecord> kernValues;
}

struct MathVariantsTable {
    UFWORD minConnectorOverlap;

    // @Field(CoverageTable vertGlyphCoverage, this)
    Offset16 vertGlyphCoverageOffset; 

    // @Field(CoverageTable horizGlyphCoverage, this)
    Offset16 horizGlyphCoverageOffset;

    uint16 vertGlyphCount;
    uint16 horizGlyphCount;

    // @Field(Array<MathGlyphConstructionTable> vertGlyphConstructions, this)
    // @Count(vertGlyphCount)
    Array<Offset16> vertGlyphConstructionOffsets;

    // @Field(Array<MathGlyphConstructionTable> horizGlyphConstructions, this)
    // @Count(horizGlyphCount)
    Array<Offset16> horizGlyphConstructionOffsets; 
}
