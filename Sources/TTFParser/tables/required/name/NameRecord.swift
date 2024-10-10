// Copyright 2024 Lie Yan

import Foundation

struct NameRecord: FixedDecodable {
    public let platformID: UInt16
    public let encodingID: UInt16
    public let languageID: UInt16
    public let nameID: UInt16
    public let length: UInt16
    public let offset: Offset16

    private enum _Offsets {
        static let platformID = 0
        static let encodingID = platformID + UInt16.encodingWidth
        static let languageID = encodingID + UInt16.encodingWidth
        static let nameID = languageID + UInt16.encodingWidth
        static let length = nameID + UInt16.encodingWidth
        static let offset = length + UInt16.encodingWidth
    }

    private init(_ bytes: UnsafePointer<UInt8>) {
        self.platformID = UInt16.decode(bytes + _Offsets.platformID)
        self.encodingID = UInt16.decode(bytes + _Offsets.encodingID)
        self.languageID = UInt16.decode(bytes + _Offsets.languageID)
        self.nameID = UInt16.decode(bytes + _Offsets.nameID)
        self.length = UInt16.decode(bytes + _Offsets.length)
        self.offset = Offset16.decode(bytes + _Offsets.offset)
    }

    static var encodingWidth: Int {
        _Offsets.offset + Offset16.encodingWidth
    }

    static func decode(_ bytes: UnsafePointer<UInt8>) -> NameRecord {
        NameRecord(bytes)
    }
}
