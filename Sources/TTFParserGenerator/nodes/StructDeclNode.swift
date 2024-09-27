// Copyright 2024 satzlich

import Foundation

// MARK: - StructDeclNode

final class StructDeclNode: SyntaxNode {
    let name: Identifier
    let fields: [FieldDeclNode]

    init(_ name: Identifier, _ fields: [FieldDeclNode]) {
        self.name = name
        self.fields = fields
    }
    
    var children: [any SyntaxNode] {
        self.fields
    }

    func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitStructDecl(self, context)
    }
}
