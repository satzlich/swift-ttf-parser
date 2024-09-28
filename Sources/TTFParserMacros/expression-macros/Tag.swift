// Copyright 2024 Lie Yan

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - Tag

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
              Self.validateRawValue(result)
        else {
            throw DefaultError.message("Invalid tag")
        }

        let hex = String(format: "0x%08X", result)

        return "Tag(\(raw: hex))"
    }

    /// Checks if the raw value is valid for a tag
    ///
    /// > Validity: Each byte within the array must have a value in the range 0x20 to 0x7E.
    /// It must have one to four non-space characters, padded with trailing
    /// spaces (byte value 0x20). A space character must not be followed by a
    /// non-space character.
    public static func validateRawValue(_ rawValue: UInt32) -> Bool {
        let space: UInt8 = 0x20
        let nonSpace: ClosedRange<UInt8> = 0x21 ... 0x7E

        var rawValue = rawValue.bigEndian

        return withUnsafeBytes(of: &rawValue) { bytes in
            if let last = bytes.lastIndex(where: { $0 != space }) {
                bytes[0 ... last].allSatisfy { nonSpace.contains($0) }
            }
            else {
                false
            }
        }
    }
}
