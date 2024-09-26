
struct MathValueRecord {
    FWORD value;
    Offset16 deviceOffset for DeviceTable;
}

struct DeviceTable {
    uint16 startSize;
    uint16 endSize;
    uint16 deltaFormat;
    array<uint16> deltaValue;
}

struct MathHeader for (majorVersion, minorVersion) == (1, 0) {
    uint16 majorVersion;
    uint16 minorVersion;
    Offset16 mathConstantsOffset for MathConstantsTable;
    Offset16 mathGlyphInfoOffset;
    Offset16 mathVariantsOffset;
}

struct MathConstantsTable {
    int16 scriptPercentScaleDown;
    int16 scriptScriptPercentScaleDown;
    UFWORD delimitedSubFormulaMinHeight;
    UFWORD displayOperatorMinHeight;
    MathValueRecord mathLeading;
    // ...
    int16 radicalDegreeBottomRaisePercent;
}
