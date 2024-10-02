// Copyright 2024 Lie Yan

struct MathTopAccentAttachmentTable: VariableDecodable {
    /**
     Offset to Coverage table, from the beginning of the MathTopAccentAttachment table.
     */
    public let topAccentCoverageOffset: Offset16

    /**
     Number of top accent attachment point values. Must be the same as the number
     of glyph IDs referenced in the Coverage table.
     */
    public let topAccentAttachmentCount: UInt16

    /**
     Array of MathValueRecords defining top accent attachment points for each covered glyph.

     Count is given by ``topAccentAttachmentCount``.
     */
    public let topAccentAttachments: FlatArray<MathValueRecord>

    

    private enum Offsets {
        static let topAccentCoverageOffset = 0
        static let topAccentAttachmentCount = topAccentCoverageOffset + Offset16.encodingWidth
        static let topAccentAttachments = topAccentAttachmentCount + UInt16.encodingWidth
    }

    private let bytes: UnsafeBufferPointer<UInt8>

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.leastWidth else {
            return nil
        }

        let baseAddress = bytes.baseAddress!

        self.topAccentCoverageOffset = Offset16.decode(baseAddress + Offsets.topAccentCoverageOffset)
        self.topAccentAttachmentCount = UInt16.decode(baseAddress + Offsets.topAccentAttachmentCount)

        guard let topAccentAttachments =
            FlatArray<MathValueRecord>(
                bytes.rebase(Offsets.topAccentAttachments),
                Int(self.topAccentAttachmentCount)
            )
        else {
            return nil
        }

        self.topAccentAttachments = topAccentAttachments
        self.bytes = bytes
    }

    static var leastWidth: Int = Offsets.topAccentAttachments

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathTopAccentAttachmentTable? {
        MathTopAccentAttachmentTable(bytes)
    }
}
