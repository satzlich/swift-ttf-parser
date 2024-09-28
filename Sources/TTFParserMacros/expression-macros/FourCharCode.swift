// Copyright 2024 Lie Yan

import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - FourCharCode

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

    /// Converts a string to the binary representation if it is a valid four-character
    /// code.
    ///
    /// - Returns: The binary representation if valid; `nil` otherwise.
    ///
    /// > Four-character code: A sequence of four bytes (typically ASCII) used to
    /// uniquely identify data formats.
    ///
    /// > Validity: Each character is ASCII.
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
