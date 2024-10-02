// Copyright 2024 Lie Yan

struct MathTable: LinkedDecodable {
    // MARK: -  Properties

    public let majorVersion: UInt16
    public let minorVersion: UInt16

    /**
     Offset to MathConstants table, from the beginning of MATH table.
     */
    private let mathConstantsOffset: Offset16

    public private(set) lazy var mathConstants: MathConstantsTable? = {
        guard let offsetValue = mathConstantsOffset.offsetValue else {
            return nil
        }
        return MathConstantsTable.decode(self.bytes.rebase(offsetValue))
    }()

    /**
     Offset to MathGlyphInfo table, from the beginning of MATH table.
     */
    public let mathGlyphInfoOffset: Offset16

    /**
     Offset to MathVariants table, from the beginning of MATH table.
     */
    public let mathVariantsOffset: Offset16

    // MARK: - Offsets

    private enum Offsets {
        static let majorVersion = 0
        static let minorVersion = majorVersion + UInt16.encodingWidth
        static let mathConstantsOffset = minorVersion + UInt16.encodingWidth
        static let mathGlyphInfoOffset = mathConstantsOffset + Offset16.encodingWidth
        static let mathVariantsOffset = mathGlyphInfoOffset + Offset16.encodingWidth
    }

    private let bytes: UnsafeBufferPointer<UInt8>

    public init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.leastWidth else {
            return nil
        }

        let baseAddress = bytes.baseAddress!

        self.majorVersion = UInt16.decode(baseAddress + Offsets.majorVersion)
        self.minorVersion = UInt16.decode(baseAddress + Offsets.minorVersion)

        guard
            self.majorVersion == 1,
            self.minorVersion == 0
        else {
            return nil
        }

        self.mathConstantsOffset = Offset16.decode(baseAddress + Offsets.mathConstantsOffset)
        self.mathGlyphInfoOffset = Offset16.decode(baseAddress + Offsets.mathGlyphInfoOffset)
        self.mathVariantsOffset = Offset16.decode(baseAddress + Offsets.mathVariantsOffset)

        self.bytes = bytes
    }

    // MARK: - LinkedDecodable

    static var leastWidth: Int = Offsets.mathVariantsOffset + Offset16.encodingWidth

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathTable? {
        MathTable(bytes)
    }
}
