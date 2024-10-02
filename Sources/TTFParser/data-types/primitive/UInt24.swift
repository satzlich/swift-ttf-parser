// Copyright 2024 Lie Yan

// MARK: - UInt24

/// 24-bit unsigned integer.
public struct UInt24: Equatable, Hashable, ExpressibleByIntegerLiteral {
    /// The semantic value embedded in UInt32
    private let rawValue: UInt32

    private init(_ rawValue: UInt32) {
        precondition(rawValue <= 0xFFFFFF)
        self.rawValue = rawValue
    }

    public init(integerLiteral value: UInt32) {
        precondition(value <= 0xFFFFFF)
        self.rawValue = value
    }

    public var intValue: Int {
        return Int(self.rawValue)
    }
}

// MARK: - UInt24 + FixedDecodable

extension UInt24: FixedDecodable {
    static var encodingWidth: Int { 3 }

    @usableFromInline
    static func decode(_ data: UnsafePointer<UInt8>) -> UInt24 {
        /*
         No performance penalty is incurred by the seemingly heavy implementation.
         Compilation with optimization emits the following instructions on x86-64
         platforms:

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
