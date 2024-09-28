// Copyright 2024 Lie Yan

// MARK: - UInt24

/// 24-bit unsigned integer.
public struct UInt24: Equatable, Hashable {
    /// The semantic value embedded in UInt32
    public let rawValue: UInt32

    // - Warning: Used only in ``UInt24.decode(_:)``.
    #if DEBUG
    private init(_ rawValue: UInt32) {
        #warning("Debug=================================")
        precondition(rawValue <= 0xFFFFFF)
        self.rawValue = rawValue
    }
    #else
    @usableFromInline
    init(_ rawValue: UInt32) {
        #warning("Release=================================")
        self.rawValue = rawValue
    }
    #endif
}

// MARK: - UInt24 + FixedDecodable

extension UInt24: FixedDecodable {
    static var encodingWidth: Int { 3 }

    /// Decode a UInt24 from a byte array
    ///
    /// When compiled with `-O` option, the following instructions are
    /// emitted on x86_64:
    /// ```assembly
    /// static decode(UnsafePointer<UInt8>) -> UInt24:
    ///     xor eax, eax
    ///     ret
    /// ```
    static func decode(_ data: UnsafePointer<UInt8>) -> UInt24 {
        let extended = [0, data[0], data[1], data[2]]
        let value = extended.withUnsafeBytes {
            $0.load(as: UInt32.self).bigEndian
        }
        return UInt24(value)
    }
}
