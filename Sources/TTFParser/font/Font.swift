// Copyright 2024 Lie Yan

import Foundation

struct Font {
    private let bytes: UnsafeBufferPointer<UInt8>

    let tableDirectory: TableDirectory

    init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        self.bytes = bytes

        guard let tableDirectory = TableDirectory.decode(bytes) else {
            return nil
        }
        self.tableDirectory = tableDirectory
    }
}
