// Copyright 2024 Lie Yan

import Foundation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import TTFParserMacros

import XCTest

final class ExprMacroTests: XCTestCase {
    static let macroProvision: [String: Macro.Type] =
        [
            "asciiCode": AsciiCode.self,
            "fourCharCode": FourCharCode.self,
            "tag": Tag.self,
        ]

    func testAsciiCode() {
        assertMacroExpansion(
            """
            #asciiCode("A")
            """,
            expandedSource:
            """
            0x41 as UInt8
            """,
            macros: Self.macroProvision
        )

        // TODO: Test invalid path
    }

    func testFourCharCode() {
        assertMacroExpansion(
            """
            #fourCharCode("ABCD")
            """,
            expandedSource:
            """
            0x41424344 as UInt32
            """,
            macros: Self.macroProvision
        )

        // TODO(low): Test invalid path
    }

    func testTag() {
        // MARK: - Normal path

        assertMacroExpansion(
            """
            #tag("ABCD")
            """,
            expandedSource:
            """
            Tag(0x41424344)
            """,
            macros: Self.macroProvision
        )

        assertMacroExpansion(
            """
            #tag("ABC ")
            """,
            expandedSource:
            """
            Tag(0x41424320)
            """,
            macros: Self.macroProvision
        )

        // padding
        assertMacroExpansion(
            """
            #tag("ABC")
            """,
            expandedSource:
            """
            Tag(0x41424320)
            """,
            macros: Self.macroProvision
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
                    Need a static string
                    """,
                    line: 1,
                    column: 1,
                    severity: .error
                ),
            ],
            macros: Self.macroProvision
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
                    Invalid tag
                    """,
                    line: 1,
                    column: 1,
                    severity: .error
                ),
            ],
            macros: Self.macroProvision
        )
    }
}
