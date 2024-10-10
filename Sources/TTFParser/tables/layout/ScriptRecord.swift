// Copyright 2024 Lie Yan

import Foundation

struct ScriptRecord: FixedDecodable {
    public let scriptTag: Tag
    public let scriptOffset: Offset16

    @usableFromInline
    enum _Offsets {
        static let scriptTag = 0
        static let scriptOffset = scriptTag + Tag.encodingWidth
    }

    init(_ bytes: UnsafePointer<UInt8>) {
        self.scriptTag = Tag.decode(bytes + _Offsets.scriptTag)
        self.scriptOffset = Offset16.decode(bytes + _Offsets.scriptOffset)
    }

    public static var encodingWidth: Int {
        _Offsets.scriptOffset + Offset16.encodingWidth
    }

    public static func decode(_ bytes: UnsafePointer<UInt8>) -> ScriptRecord {
        ScriptRecord(bytes)
    }
}
