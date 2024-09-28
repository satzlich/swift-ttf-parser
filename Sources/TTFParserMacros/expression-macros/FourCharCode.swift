// Copyright 2024 Lie Yan

import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - FourCharCode

/**
 An expression macro that converts a string literal to its four-character code.

 # Specification
 > Four-character code (FourCC): A sequence of four bytes (typically ASCII) used to
 uniquely identify data formats.

 > Validity: As to this macro, each byte is restricted to ASCII codes.

 Given a string literal, returns its four-character code if it does specify a valid
 one; otherwise, reports an error.

 The big-endian byte representation of the return value gives the "ultimate"
 four-character code by definition.

 # Usage Example
 ```swift
 // Declaration
 @freestanding(expression)
 public macro fourCharCode(_ stringLiteral: String) -> UInt32 =
     #externalMacro(module: "TTFParserMacros", type: "FourCharCode")

 // Usage
 #fourCharCode("ABCD") == 0x41424344 as UInt32
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

     # Specification

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
