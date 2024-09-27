// Copyright 2024 satzlich

import Foundation

// MARK: - SyntaxVisitor

class SyntaxVisitor<R, C> {
    func visitSyntax(_ syntax: SyntaxNode, _ context: C) -> R {
        fatalError("not implemented")
    }

    func visitStructDecl(_ structDecl: StructDeclNode, _ context: C) -> R {
        self.visitSyntax(structDecl, context)
    }

    func visitVariableDecl(_ variableDecl: VariableDeclNode, _ context: C) -> R {
        self.visitSyntax(variableDecl, context)
    }

    func visitType(_ type: TypeNode, _ context: C) -> R {
        self.visitSyntax(type, context)
    }
}
