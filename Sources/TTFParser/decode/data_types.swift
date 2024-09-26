// Copyright 2024 satzlich

import TTFParserMacros

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
    typealias Base = Int32

    let rawValue: Int32

    init(_ rawValue: Int32) {
        self.rawValue = rawValue
    }

    func as_float() -> Float {
        return Float(self.rawValue) / 65536
    }

    func as_double() -> Double {
        return Double(self.rawValue) / 65536
    }
}

/// int16 that describes a quantity in font design units.
typealias FWORD = Int16
/// uint16 that describes a quantity in font design units.
typealias UFWORD = UInt16

// MARK: - F2DOT14

/// 16-bit signed fixed number with the low 14 bits of fraction (2.14).
struct F2DOT14 {
    typealias Base = Int16

    let rawValue: Int16

    init(_ rawValue: Int16) {
        self.rawValue = rawValue
    }

    func as_float() -> Float {
        return Float(self.rawValue) / 16384
    }

    func as_double() -> Double {
        return Double(self.rawValue) / 16384
    }
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
    func is_valid() -> Bool {
        TTFParserMacros.is_valid_tag(self.rawValue)
    }
}

// MARK: - Offset

protocol OffsetProtocol {
    associatedtype Base
    associatedtype RawValue

    init(_ base: Base)

    var rawValue: RawValue { get }
    var isNull: Bool { get }
}

struct Offset<Base: BinaryInteger>: OffsetProtocol {
    typealias RawValue = Base

    let _base: Base

    init(_ base: Base) {
        self._base = base
    }

    var rawValue: Base {
        self._base
    }

    var isNull: Bool {
        self._base == 0
    }
}

/// 8-bit offset to a table, same as uint8, NULL offset = 0x00
typealias Offset8 = Offset<UInt8>

/// Short offset to a table, same as uint16, NULL offset = 0x0000
typealias Offset16 = Offset<UInt16>

/// 24-bit offset to a table, same as uint24, NULL offset = 0x000000
struct Offset24: OffsetProtocol {
    typealias Base = UInt24
    typealias RawValue = Base.RawValue

    let _base: Base

    init(_ base: Base) {
        self._base = base
    }

    var rawValue: RawValue {
        self._base.rawValue
    }

    var isNull: Bool {
        self._base.rawValue == 0
    }
}

/// Long offset to a table, same as uint32, NULL offset = 0x00000000
typealias Offset32 = Offset<UInt32>

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
    ///
    /// Version `0x00005000` has minor version `5` instead of `0x5000`.
    var minor: UInt16 {
        let u = UInt16(self.rawValue & 0xFFFF)
        assert(u & 0x0FFF == 0)
        return u >> 12
    }
}
