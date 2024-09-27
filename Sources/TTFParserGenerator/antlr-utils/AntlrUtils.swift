// Copyright 2024 satzlich

import Foundation

enum AntlrUtils {
    /// Translate Antlr syntax tree to our syntax tree
    public static func translate(_ specification: SpecificationParser.SpecificationContext) -> SpecificationNode? {
        let idAllocator = SyntaxNodeIdAllocator()
        let visitor = TranslationVisitor(idAllocator)

        return specification.accept(visitor) as? SpecificationNode
    }
}
