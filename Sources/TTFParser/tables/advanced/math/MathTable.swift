// Copyright 2024 Lie Yan

// MARK: - MathTable

struct MathTable: SafeDecodable {
    public let majorVersion: UInt16
    public let minorVersion: UInt16

    public let constants: MathConstantsTable?
    public let glyphInfo: MathGlyphInfoTable?
    public let variants: MathVariantsTable?

    private enum Offsets {
        static let majorVersion = 0
        static let minorVersion = majorVersion + UInt16.encodingWidth
        static let mathConstantsOffset = minorVersion + UInt16.encodingWidth
        static let mathGlyphInfoOffset = mathConstantsOffset + Offset16.encodingWidth
        static let mathVariantsOffset = mathGlyphInfoOffset + Offset16.encodingWidth
    }

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        self.majorVersion = UInt16.decode(bytes.baseAddress! + Offsets.majorVersion)
        self.minorVersion = UInt16.decode(bytes.baseAddress! + Offsets.minorVersion)

        guard self.majorVersion == 1,
              self.minorVersion == 0
        else {
            return nil
        }

        let mathConstantsOffset = Offset16.decode(bytes.baseAddress! + Offsets.mathConstantsOffset)
        let mathGlyphInfoOffset = Offset16.decode(bytes.baseAddress! + Offsets.mathGlyphInfoOffset)
        let mathVariantsOffset = Offset16.decode(bytes.baseAddress! + Offsets.mathVariantsOffset)

        self.constants = mathConstantsOffset.lift(bytes)
        self.glyphInfo = mathGlyphInfoOffset.lift(bytes)
        self.variants = mathVariantsOffset.lift(bytes)
    }

    static let minWidth: Int = Offsets.mathVariantsOffset + Offset16.encodingWidth

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathTable? {
        MathTable(bytes)
    }
}
