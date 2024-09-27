// Copyright 2024 satzlich

import Foundation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import TTFParserMacros

import XCTest

final class ExprMacroTests: XCTestCase {
    private let MACROS: [String: Macro.Type] =
        [
            "asciiCode": AsciiCode.self,
            "fourCharCode": FourCharCode.self,
            "tag": Tag.self,
        ]

    func test_ascii_code() {
        assertMacroExpansion(
            """
            #asciiCode("a")
            """,
            expandedSource:
            """
            0x61 as UInt8
            """,
            macros: self.MACROS
        )

        // TODO: Test invalid path
    }

    func test_four_char_code() {
        assertMacroExpansion(
            """
            #fourCharCode("ssty")
            """,
            expandedSource:
            """
            0x73737479 as UInt32
            """,
            macros: self.MACROS
        )

        // TODO(low): Test invalid path
    }

    func test_tag() {
        // MARK: - Normal path

        assertMacroExpansion(
            """
            #tag("ssty")
            """,
            expandedSource:
            """
            Tag(0x73737479)
            """,
            macros: self.MACROS
        )

        assertMacroExpansion(
            """
            #tag("sst ")
            """,
            expandedSource:
            """
            Tag(0x73737420)
            """,
            macros: self.MACROS
        )

        // padding
        assertMacroExpansion(
            """
            #tag("sst")
            """,
            expandedSource:
            """
            Tag(0x73737420)
            """,
            macros: self.MACROS
        )

        // MARK: - Invalid path

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
