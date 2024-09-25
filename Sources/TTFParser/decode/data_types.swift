// Copyright 2024 satzlich

// MARK: - UInt24

/// 24-bit unsigned integer.
///
/// - Note: No companion Int24 struct, since it's not needed.
struct UInt24: Equatable, Comparable, Hashable {
    typealias RawValue = UInt32

    let rawValue: RawValue

    init(_ value: UInt32) {
        precondition(value <= 0xFFFFFF)
        self.rawValue = value
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
    let rawValue: Int64
}

// MARK: - Tag

/// Array of four uint8s (length = 32 bits) used to identify a table, design-variation
/// axis, script, language system, feature, or baseline.
struct Tag {
    // TODO: research on its usage and design it

    let rawValue: UInt32

    init(_ value: UInt32) {
        self.rawValue = value
    }
}

// MARK: - Offset8

/// 8-bit offset to a table, same as uint8, NULL offset = 0x00
struct Offset8: Offset {
    typealias Base = UInt8
    typealias RawValue = UInt8

    let rawValue: UInt8

    init(_ value: Base) {
        self.rawValue = value
    }
}

// MARK: - Offset16

/// Short offset to a table, same as uint16, NULL offset = 0x0000
struct Offset16: Offset {
    typealias Base = UInt16
    typealias RawValue = UInt16

    let rawValue: UInt16

    init(_ value: Base) {
        self.rawValue = value
    }
}

// MARK: - Offset24

/// 24-bit offset to a table, same as uint24, NULL offset = 0x000000
struct Offset24: Offset {
    typealias Base = UInt24
    typealias RawValue = Base.RawValue

    let rawValue: Base.RawValue

    init(_ value: Base) {
        self.rawValue = value.rawValue
    }
}

// MARK: - Offset32

/// Long offset to a table, same as uint32, NULL offset = 0x00000000
struct Offset32: Offset {
    typealias Base = UInt32
    typealias RawValue = UInt32

    let rawValue: UInt32

    init(_ value: Base) {
        self.rawValue = value
    }
}

// MARK: - Version16Dot16

/// Packed 32-bit value with major and minor version numbers.
struct Version16Dot16 {
    //
}
