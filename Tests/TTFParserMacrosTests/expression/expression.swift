// Copyright 2024 satzlich

import Foundation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import Testing
import TTFParserMacros

import XCTest

final class ExprMacroTests: XCTestCase {
    private let MACROS: [String: Macro.Type] =
        [
            "ascii_code": AsciiCode.self,
            "four_char_code": FourCharCode.self,
            "tag": Tag.self,
        ]

    func test_ascii_code() {
        assertMacroExpansion(
            """
            #ascii_code("a")
            """,
            expandedSource:
            """
            97 as UInt8
            """,
            macros: self.MACROS
        )
    }

    func test_four_char_code() {
        assertMacroExpansion(
            """
            #four_char_code("ssty")
            """,
            expandedSource:
            """
            1936946297 as UInt32
            """,
            macros: self.MACROS
        )
    }

    func test_tag() {
        assertMacroExpansion(
            """
            #tag("ssty")
            """,
            expandedSource:
            """
            Tag(1936946297)
            """,
            macros: self.MACROS
        )

        assertMacroExpansion(
            """
            #tag(1024)
            """,
            expandedSource:
            """
            #tag(1024)
            """,
            diagnostics: [
                DiagnosticSpec(
                    message:
                    """
                    message("Need a static string")
                    """,
                    line: 1,
                    column: 1,
                    severity: .error
                ),
            ],
            macros: self.MACROS
        )

        assertMacroExpansion(
            """
            #tag("s ty")
            """,
            expandedSource:
            """
            #tag("s ty")
            """,
            diagnostics: [
                DiagnosticSpec(
                    message:
                    """
                    message("Invalid tag")
                    """,
                    line: 1,
                    column: 1,
                    severity: .error
                ),
            ],
            macros: self.MACROS
        )
    }
}
