// Copyright 2024 satzlich

import Foundation

// MARK: - Version16Dot16

/// Packed 32-bit value with major and minor version numbers.
///
/// - Note: This type is used only in the 'maxp', 'post' and 'vhea' tables, and
/// will not be used for any other tables in the future.
struct Version16Dot16 {
    /// major.minor version encoded in UInt32
    let rawValue: UInt32

    init(_ rawValue: UInt32) {
        self.rawValue = rawValue
    }
}

// MARK: - Version16Dot16 + FixedDecodable

extension Version16Dot16: FixedDecodable {
    static var encodingWidth: Int { UInt32.encodingWidth }

    static func decode(_ data: UnsafePointer<UInt8>) -> Version16Dot16 {
        Version16Dot16(UInt32.decode(data))
    }
}
