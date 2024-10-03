// Copyright 2024 Lie Yan

// MARK: - MathTable

struct MathTable: SafeDecodable {
    public let majorVersion: UInt16
    public let minorVersion: UInt16

    /**
     Offset to MathConstants table, from the beginning of MATH table.
     */
    public let mathConstantsOffset: Offset16

    /**
     Offset to MathGlyphInfo table, from the beginning of MATH table.
     */
    public let mathGlyphInfoOffset: Offset16

    /**
     Offset to MathVariants table, from the beginning of MATH table.
     */
    public let mathVariantsOffset: Offset16

    private enum Offsets {
        static let majorVersion = 0
        static let minorVersion = majorVersion + UInt16.encodingWidth
        static let mathConstantsOffset = minorVersion + UInt16.encodingWidth
        static let mathGlyphInfoOffset = mathConstantsOffset + Offset16.encodingWidth
        static let mathVariantsOffset = mathGlyphInfoOffset + Offset16.encodingWidth
    }

    private let bytes: UnsafeBufferPointer<UInt8>

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

        self.mathConstantsOffset = Offset16.decode(bytes.baseAddress! + Offsets.mathConstantsOffset)
        self.mathGlyphInfoOffset = Offset16.decode(bytes.baseAddress! + Offsets.mathGlyphInfoOffset)
        self.mathVariantsOffset = Offset16.decode(bytes.baseAddress! + Offsets.mathVariantsOffset)

        self.bytes = bytes
    }

    static var minWidth: Int = Offsets.mathVariantsOffset + Offset16.encodingWidth

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathTable? {
        MathTable(bytes)
    }
}

extension MathTable {
    public var mathConstants: MathConstantsTable? {
        .decode(self.bytes.rebase(Offsets.mathConstantsOffset))
    }

    public var mathGlyphInfo: MathGlyphInfoTable? {
        .decode(self.bytes.rebase(Offsets.mathGlyphInfoOffset))
    }

    public var mathVariants: MathVariantsTable? {
        .decode(self.bytes.rebase(Offsets.mathVariantsOffset))
    }
}
