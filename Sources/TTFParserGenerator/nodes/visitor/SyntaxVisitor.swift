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

    func visitStructMember(_ structMember: StructMemberNode, _ context: C) -> R {
        self.visitSyntax(structMember, context)
    }

    func visitType(_ type: TypeNode, _ context: C) -> R {
        self.visitSyntax(type, context)
    }

    func visitVariableDecl(_ variableDecl: VariableDeclNode, _ context: C) -> R {
        self.visitSyntax(variableDecl, context)
    }
}
