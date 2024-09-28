// Copyright 2024 Lie Yan

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - FourCharCode

/**
 An expression macro that converts a string literal to its four-character code.

 # Definition
 A **four-character code** is a sequence of four bytes (typically ASCII), which is
 used to uniquely identify data formats. A string of four ASCII characters naturally
 specifies a four-character code.

 As to this macro, we restrict ourselves to the typical case where each byte is ASCII
 (printable or non-printable).

 # Functionality
 Given a string literal, the macro returns a 32-bit unsigned integer whose big-endian
 representation (available as ``UInt32.bigEndian``) gives the four-character code if
 the input string consists of four ASCII characters; otherwise, reports an error.

 The numerical meaning of the return value remains the same disregarding change of
 machine endianness.
 
 # Usage Example
 ```swift
 // Declaration
 @freestanding(expression)
 public macro fourCharCode(_ stringLiteral: String) -> UInt32 =
     #externalMacro(module: "TTFParserMacros", type: "FourCharCode")

 // Usage
 var code = #fourCharCode("ABCD") // 0x41424344 as UInt32
 ```
 */
public struct FourCharCode: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard
            node.arguments.count == 1,
            let argument = node.arguments.first?.expression,
            let string = SyntaxUtils.getStringLiteral(argument)
        else {
            throw DefaultError.message("Need a static string")
        }

        guard let result = Self.fourCharCode(for: string) else {
            throw DefaultError.message("Invalid four-character code")
        }

        let hex = String(format: "0x%08X", result)

        return "\(raw: hex) as UInt32"
    }

    /**
     Converts a string to a four-character code.
     
     Given a string, returns nil if the string does not consist of four ASCII
     characters; otherwise, returns a 32-bit unsigned integer whose big-endian
     byte representation gives the four-character code.
     */
    public static func fourCharCode(for characters: String) -> UInt32? {
        guard characters.count == 4 else {
            return nil
        }

        var result: UInt32 = 0
        for character in characters {
            result = result << 8
            guard let asciiValue = character.asciiValue else {
                return nil
            }
            result += UInt32(asciiValue)
        }
        return result
    }
}
