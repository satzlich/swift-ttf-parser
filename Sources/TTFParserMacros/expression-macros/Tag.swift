// Copyright 2024 Lie Yan

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - Tag

/**
 An expression macro that converts a string literal to a tag.

 # Specification
 Given a string literal, returns a value fo ``Tag`` if it does specify a valid one;
 otherwise, reports an error.

 # Usage Example
 ```swift
 // Declaration
 @freestanding(expression)
 public macro tag(_ stringLiteral: String) -> Tag =
     #externalMacro(module: "TTFParserMacros", type: "Tag")

 // Usage
 #tag("ABCD") == Tag(0x41424344)
 #tag("ABC ") == Tag(0x41424320)
 #tag("ABC")  == Tag(0x41424320)
 ```
 */
public struct Tag: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let argument = node.arguments.first?.expression,
              var string = SyntaxUtils.getStringLiteral(argument)
        else {
            throw DefaultError.message("Need a static string")
        }

        if string.count < 4 {
            string += String(repeating: " ", count: 4 - string.count)
        }

        guard let result = FourCharCode.fourCharCode(for: string),
              Self.validate(result)
        else {
            throw DefaultError.message("Invalid tag")
        }

        let hex = String(format: "0x%08X", result)

        return "Tag(\(raw: hex))"
    }

    /**
     Returns true iff the given value is a valid tag.

     # Specification
     Returns true iff the given value is a valid tag *when using its big-endian byte
     representation.*
     */
    public static func validate(_ value: UInt32) -> Bool {
        let space: UInt8 = 0x20
        let nonSpace: ClosedRange<UInt8> = 0x21 ... 0x7E

        var bigEndian = value.bigEndian

        return withUnsafeBytes(of: &bigEndian) { bytes in
            if let last = bytes.lastIndex(where: { $0 != space }) {
                bytes[0 ... last].allSatisfy { nonSpace.contains($0) }
            }
            else {
                false
            }
        }
    }
}
