// Copyright 2024 satzlich

import Foundation

// MARK: - SyntaxVisitor

class SyntaxVisitor<R, C: AnyObject> {
    func visitSyntax(_ syntax: SyntaxNode, _ context: C) -> R {
        fatalError("not implemented")
    }

    func visitStructDecl(_ structDecl: StructDeclNode, _ context: C) -> R {
        self.visitSyntax(structDecl, context)
    }

    func visitFieldDecl(_ fieldDecl: FieldDeclNode, _ context: C) -> R {
        self.visitSyntax(fieldDecl, context)
    }

    func visitType(_ type: TypeNode, _ context: C) -> R {
        self.visitSyntax(type, context)
    }
}
