// Copyright 2024 Lie Yan

import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - AsciiCode

public struct AsciiCode: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard
            node.arguments.count == 1,
            let argument = node.arguments.first?.expression,
            let string = SyntaxUtils.getStringLiteral(argument),
            string.count == 1
        else {
            throw DefaultError.message("Need a single character")
        }

        guard let result = string.first?.asciiValue else {
            throw DefaultError.message("Need an ascii character")
        }

        let hex = String(format: "0x%02X", result)

        return "\(raw: hex) as UInt8"
    }
}
