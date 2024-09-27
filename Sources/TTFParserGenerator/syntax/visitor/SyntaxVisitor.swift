// Copyright 2024 satzlich

import Foundation

// MARK: - SyntaxVisitor

open class SyntaxVisitor<R, C: AnyObject> {
    /// Default visiting method.
    open func visitSyntax(_ syntax: SyntaxNode, _ context: C) -> R {
        fatalError("not implemented")
    }

    open func visitSpecification(_ specification: SpecificationNode, _ context: C) -> R {
        self.visitSyntax(specification, context)
    }

    open func visitStructDecl(_ structDecl: StructDeclNode, _ context: C) -> R {
        self.visitSyntax(structDecl, context)
    }

    open func visitStructMember(_ structMember: StructMemberNode, _ context: C) -> R {
        self.visitSyntax(structMember, context)
    }

    open func visitType(_ type: TypeNode, _ context: C) -> R {
        self.visitSyntax(type, context)
    }

    open func visitVariableDecl(_ variableDecl: VariableDeclNode, _ context: C) -> R {
        self.visitSyntax(variableDecl, context)
    }
}
