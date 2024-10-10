// Copyright 2024 Lie Yan

import Foundation

struct LangTagRecord: FixedDecodable {
    public let length: UInt16
    public let langTagOffset: Offset16

    private enum _Offsets {
        static let length = 0
        static let langTagOffset = length + UInt16.encodingWidth
    }

    private init(_ bytes: UnsafePointer<UInt8>) {
        self.length = UInt16.decode(bytes + _Offsets.length)
        self.langTagOffset = Offset16.decode(bytes + _Offsets.langTagOffset)
    }

    static var encodingWidth: Int {
        _Offsets.langTagOffset + Offset16.encodingWidth
    }

    static func decode(_ bytes: UnsafePointer<UInt8>) -> LangTagRecord {
        LangTagRecord(bytes)
    }
}
