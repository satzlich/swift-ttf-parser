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

    /// major version
    var major: UInt16 {
        UInt16(self.rawValue >> 16)
    }

    /// minor version
    ///
    /// Version `0x00005000` has minor version `5` instead of `0x5000`.
    var minor: UInt16 {
        UInt16(self.rawValue & 0xFFFF) >> 12
    }
}

// MARK: - Version16Dot16 + FixedDecodable

extension Version16Dot16: FixedDecodable {
    static var encodingWidth: Int { UInt32.encodingWidth }

    static func decode(_ data: UnsafePointer<UInt8>) -> Version16Dot16 {
        Version16Dot16(UInt32.decode(data))
    }
}
