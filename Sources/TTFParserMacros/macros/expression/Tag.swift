// Copyright 2024 satzlich

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
              var string = getStringLiteral(argument)
        else {
            throw DefaultError.message("Need a static string")
        }

        if string.count < 4 {
            string += String(repeating: " ", count: 4 - string.count)
        }

        guard let result = four_char_code(for: string),
              is_valid_tag(result)
        else {
            throw DefaultError.message("Invalid tag")
        }

        let hex = String(format: "0x%08X", result)

        return "Tag(\(raw: hex))"
    }
}

/// Returns true if the tag is valid in terms of syntax.
///
/// - Note: Each byte within the array must have a value in the range 0x20 to 0x7E.
/// It must have one to four non-space characters, padded with trailing
/// spaces (byte value 0x20). A space character must not be followed by a
/// non-space character.
public func is_valid_tag(_ rawValue: UInt32) -> Bool {
    let SPACE: UInt8 = 0x20
    let NON_SPACE: ClosedRange<UInt8> = 0x21 ... 0x7E

    var rawValue = rawValue.bigEndian

    return withUnsafeBytes(of: &rawValue) { bytes in
        if let last = bytes.lastIndex(where: { $0 != SPACE }) {
            bytes[0 ... last].allSatisfy { NON_SPACE.contains($0) }
        }
        else {
            false
        }
    }
}
