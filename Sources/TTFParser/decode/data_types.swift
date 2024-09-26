// Copyright 2024 satzlich

// MARK: - UInt24

/// 24-bit unsigned integer.
///
/// - Note: No companion Int24 struct, since it's not needed.
struct UInt24: Equatable, Comparable, Hashable {
    typealias RawValue = UInt32

    let rawValue: RawValue

    init(_ rawValue: UInt32) {
        precondition(rawValue <= 0xFFFFFF)
        self.rawValue = rawValue
    }

    static func < (lhs: UInt24, rhs: UInt24) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

// MARK: - Fixed

/// 32-bit signed fixed-point number (16.16)
struct Fixed {
    // TODO: research on its usage and design it
    let rawValue: Int32
}

/// int16 that describes a quantity in font design units.
typealias FWORD = Int16
/// uint16 that describes a quantity in font design units.
typealias UFWORD = UInt16

// MARK: - F2DOT14

/// 16-bit signed fixed number with the low 14 bits of fraction (2.14).
struct F2DOT14 {
    // TODO: research on its usage and design it
    let rawValue: Int16
}

// MARK: - LONGDATETIME

/// Date and time represented in number of seconds since 12:00 midnight, January
/// 1, 1904, UTC. The value is represented as a signed 64-bit integer.
struct LONGDATETIME {
    typealias Base = Int64

    let rawValue: Int64

    init(_ rawValue: Int64) {
        self.rawValue = rawValue
    }
}

// MARK: - Tag

/// Array of four uint8s (length = 32 bits) used to identify a table, design-variation
/// axis, script, language system, feature, or baseline.
struct Tag: Equatable, Hashable {
    typealias Base = UInt32

    let rawValue: UInt32

    init(_ rawValue: UInt32) {
        self.rawValue = rawValue
    }

    /// Returns true if the tag is valid in terms of syntax.
    ///
    /// - Note: Each byte within the array must have a value in the range 0x20 to 0x7E.
    /// It must have one to four non-space characters, padded with trailing
    /// spaces (byte value 0x20). A space character must not be followed by a
    /// non-space character.
    func is_valid() -> Bool {
        let SPACE: UInt8 = 0x20
        let NON_SPACE: ClosedRange<UInt8> = 0x21 ... 0x7E

        var rawValue = rawValue

        return withUnsafeBytes(of: &rawValue) { bytes in
            if let last = bytes.lastIndex(where: { $0 != SPACE }) {
                bytes[0 ... last].allSatisfy { NON_SPACE.contains($0) }
            }
            else {
                false
            }
        }
    }
}

// MARK: - Offset

struct Offset<Base, RawValue> {
    let base: Base

    init(_ base: Base) {
        self.base = base
    }

    func raw_value() -> RawValue
        where Base == RawValue
    {
        self.base
    }

    func raw_value() -> RawValue
        where Base == UInt24, RawValue == Base.RawValue
    {
        self.base.rawValue
    }

    func is_null() -> Bool where Base: UnsignedInteger {
        self.base == 0
    }

    func is_null() -> Bool where Base == UInt24 {
        self.base.rawValue == 0
    }
}

/// 8-bit offset to a table, same as uint8, NULL offset = 0x00
typealias Offset8 = Offset<UInt8, UInt8>

/// Short offset to a table, same as uint16, NULL offset = 0x0000
typealias Offset16 = Offset<UInt16, UInt16>

/// 24-bit offset to a table, same as uint24, NULL offset = 0x000000
typealias Offset24 = Offset<UInt24, UInt24.RawValue>

/// Long offset to a table, same as uint32, NULL offset = 0x00000000
typealias Offset32 = Offset<UInt32, UInt32>

// MARK: - Version16Dot16

/// Packed 32-bit value with major and minor version numbers.
///
/// - Note: This type is used only in the 'maxp', 'post' and 'vhea' tables, and
/// will not be used for any other tables in the future.
struct Version16Dot16 {
    typealias Base = UInt32

    let rawValue: UInt32

    init(_ rawValue: UInt32) {
        self.rawValue = rawValue
    }

    /// major version
    var major: UInt16 {
        UInt16(self.rawValue >> 16)
    }

    /// minor version
    var minor: UInt16 {
        let u = UInt16(self.rawValue & 0xFFFF)
        assert(u & 0x0FFF == 0)
        return u >> 12
    }
}
