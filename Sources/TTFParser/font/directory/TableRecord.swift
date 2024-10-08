// Copyright 2024 Lie Yan

// MARK: - TableRecord

struct TableRecord: FixedDecodable {
    public let tableTag: Tag
    public let checksum: UInt32
    public let offset: Offset32
    public let length: UInt32

    private enum _Offsets {
        static let tableTag = 0
        static let checksum = tableTag + Tag.encodingWidth
        static let offset = checksum + UInt32.encodingWidth
        static let length = offset + Offset32.encodingWidth
    }

    private init(_ bytes: UnsafePointer<UInt8>) {
        self.tableTag = Tag.decode(bytes + _Offsets.tableTag)
        self.checksum = UInt32.decode(bytes + _Offsets.checksum)
        self.offset = Offset32.decode(bytes + _Offsets.offset)
        self.length = UInt32.decode(bytes + _Offsets.length)
    }

    public static var encodingWidth: Int = _Offsets.length + UInt32.encodingWidth

    public static func decode(_ bytes: UnsafePointer<UInt8>) -> TableRecord {
        return TableRecord(bytes)
    }
}

// MARK: - TableRecord + Identifiable

extension TableRecord: Identifiable {
    public typealias ID = Tag

    public var id: Tag {
        self.tableTag
    }
}
