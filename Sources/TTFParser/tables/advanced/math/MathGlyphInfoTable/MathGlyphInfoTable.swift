// Copyright 2024 Lie Yan

// MARK: - MathGlyphInfoTable

public struct MathGlyphInfoTable: SafeDecodable {
    public let italicsCorrections: MathItalicsCorrectionInfoTable?
    public let topAccentAttachments: MathTopAccentAttachmentTable?
    public let extendedShapeCoverage: CoverageTable?
    public let kerns: MathKernInfoTable?

    private enum _Offsets {
        static let mathItalicsCorrectionInfoOffset = 0
        static let mathTopAccentAttachmentOffset = mathItalicsCorrectionInfoOffset + Offset16.encodingWidth
        static let extendedShapeCoverageOffset = mathTopAccentAttachmentOffset + Offset16.encodingWidth
        static let mathKernInfoOffset = extendedShapeCoverageOffset + Offset16.encodingWidth
    }

    private let bytes: UnsafeBufferPointer<UInt8>

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        let mathItalicsCorrectionInfoOffset
            = Offset16.decode(bytes.baseAddress! + _Offsets.mathItalicsCorrectionInfoOffset)
        let mathTopAccentAttachmentOffset
            = Offset16.decode(bytes.baseAddress! + _Offsets.mathTopAccentAttachmentOffset)
        let extendedShapeCoverageOffset
            = Offset16.decode(bytes.baseAddress! + _Offsets.extendedShapeCoverageOffset)
        let mathKernInfoOffset
            = Offset16.decode(bytes.baseAddress! + _Offsets.mathKernInfoOffset)

        self.bytes = bytes

        italicsCorrections = mathItalicsCorrectionInfoOffset.lift(bytes)
        topAccentAttachments = mathTopAccentAttachmentOffset.lift(bytes)
        extendedShapeCoverage = extendedShapeCoverageOffset.lift(bytes)
        kerns = mathKernInfoOffset.lift(bytes)
    }

    public static let minWidth: Int = _Offsets.mathKernInfoOffset + Offset16.encodingWidth

    public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathGlyphInfoTable? {
        MathGlyphInfoTable(bytes)
    }
}
