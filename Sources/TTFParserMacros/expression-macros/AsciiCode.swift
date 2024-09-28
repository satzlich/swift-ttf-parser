// Copyright 2024 Lie Yan

import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - AsciiCode

/**
 An expression macro that converts a character literal to its ASCII code.

 # Specification
 > Functionality:
 Given a character literal, returns its ASCII code if it is in
 the ASCII charset; otherwise, reports an error.

 # Usage Example
 ```swift
 // Declaration
 @freestanding(expression)
 public macro asciiCode(_ charLiteral: Character) -> UInt8 =
     #externalMacro(module: "TTFParserMacros", type: "AsciiCode")

 // Usage
 #asciiCode("A") == 0x41 as UInt8
 ```
 */
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
