// Copyright 2024 satzlich

import Foundation

// MARK: - UInt24

/// 24-bit unsigned integer.
///
/// - Note: No companion Int24 struct, since it's not needed.
struct UInt24 {
    let rawValue: UInt32

    init(_ value: UInt32) {
        precondition(value <= 0xFFFFFF)
        self.rawValue = value
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
    let rawValue: Int16
}
