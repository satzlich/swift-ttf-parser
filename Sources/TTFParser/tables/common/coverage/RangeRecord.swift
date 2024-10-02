// Copyright 2024 Lie Yan

struct RangeRecord: FixedDecodable {
    public let startGlyphID: UInt16
    public let endGlyphID: UInt16
    public let startCoverageIndex: UInt16

    private enum Offsets {
        static let startGlyphID = 0
        static let endGlyphID = startGlyphID + UInt16.encodingWidth
        static let startCoverageIndex = endGlyphID + UInt16.encodingWidth
    }

    private init(_ bytes: UnsafePointer<UInt8>) {
        self.startGlyphID = UInt16.decode(bytes + Offsets.startGlyphID)
        self.endGlyphID = UInt16.decode(bytes + Offsets.endGlyphID)
        self.startCoverageIndex = UInt16.decode(bytes + Offsets.startCoverageIndex)
    }

    static var encodingWidth: Int = Offsets.startGlyphID + UInt16.encodingWidth

    static func decode(_ bytes: UnsafePointer<UInt8>) -> RangeRecord {
        RangeRecord(bytes)
    }
}
