// Copyright 2024 Lie Yan

import Foundation

struct ScriptListTable: SafeDecodable {
    public let scriptCount: UInt16
    public let scriptRecords: FlatArray<ScriptRecord>

    enum _Offsets {
        static let scriptCount = 0
        static let scriptRecords = scriptCount + UInt16.encodingWidth
    }

    init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        self.scriptCount = UInt16.decode(bytes.baseAddress! + _Offsets.scriptCount)

        do {
            let bytes = bytes.rebase(_Offsets.scriptRecords)
            let count = Int(scriptCount)
            guard let scriptRecords = FlatArray<ScriptRecord>(bytes, count) else {
                return nil
            }
            self.scriptRecords = scriptRecords
        }
    }

    static var minWidth: Int {
        _Offsets.scriptRecords
    }

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> ScriptListTable? {
        ScriptListTable(bytes)
    }
}
