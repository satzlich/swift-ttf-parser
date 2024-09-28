// Copyright 2024 Lie Yan

// MARK: - UInt24

/// 24-bit unsigned integer.
public struct UInt24: Equatable, Hashable {
    /// The semantic value embedded in UInt32
    public let rawValue: UInt32

    /// - Warning: Used in ``UInt24.decode(_:)`` only.
    private init(_ rawValue: UInt32) {
        precondition(rawValue <= 0xFFFFFF)
        self.rawValue = rawValue
    }
}

// MARK: - UInt24 + FixedDecodable

extension UInt24: FixedDecodable {
    static var encodingWidth: Int { 3 }

    @usableFromInline
    static func decode(_ data: UnsafePointer<UInt8>) -> UInt24 {
        /**
         No performance penalty is incurred by the seemingly heavy implementation.
         Compilation with optimization emits the following instructions on x86-64:

         ```asm
         static output.UInt24.decode(Swift.UnsafePointer<Swift.UInt8>) -> output.UInt24:
                 xor     eax, eax
                 ret
         ```
         */

        let extended = [0, data[0], data[1], data[2]]
        let value = extended.withUnsafeBytes {
            $0.load(as: UInt32.self).bigEndian
        }
        return UInt24(value)
    }
}
