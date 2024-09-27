// Copyright 2024 satzlich

import Foundation

import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - AsciiCode

public struct AsciiCode: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let argument = node.arguments.first?.expression,
              let text = getStringLiteral(argument)
        else {
            throw DefaultError.message("Need a single character")
        }

        guard text.count == 1 else {
            throw DefaultError.message("Need a single character")
        }

        guard let result = text.first?.asciiValue else {
            throw DefaultError.message("Invalid ascii code")
        }

        let hex = String(format: "0x%02X", result)

        return "\(raw: hex) as UInt8"
    }
}
