// Copyright 2024 satzlich

import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - FourCharCode

public struct FourCharCode: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let argument = node.arguments.first?.expression,
              let string = getStringLiteral(argument)
        else {
            throw DefaultError.message("Need a static string")
        }

        guard let result = four_char_code(for: string) else {
            throw DefaultError.message("Invalid four-character code")
        }

        return "\(raw: result) as UInt32"
    }
}

func four_char_code(for characters: String) -> UInt32? {
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
