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

// MARK: - Offset

struct Offset<T, R> {
    let base: T

    init(_ base: T) {
        self.base = base
    }

    func rawValue() -> R where T == R {
        self.base
    }

    func rawValue() -> R where T == UInt24, R == T.RawValue {
        self.base.rawValue
    }

    func isNull() -> Bool where T: BinaryInteger {
        self.base == 0
    }

    func isNull() -> Bool where T == UInt24 {
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
struct Version16Dot16 {
    //
}
