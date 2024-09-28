// Copyright 2024 Lie Yan

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxMacros

@main
struct TTFParserMacros: CompilerPlugin {
    var providingMacros: [Macro.Type] = [
        // Expressions
        AsciiCode.self,
        FourCharCode.self,
        Tag.self,
    ]
}
