// Copyright 2024 satzlich

import Foundation

// MARK: - SyntaxNode

protocol SyntaxNode {
    func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R

//    var children: [SyntaxNode] { get }
}

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

// MARK: - StructDeclNode

final class StructDeclNode: SyntaxNode {
    let name: Identifier
    let fields: [VariableDeclNode]

    init(_ name: Identifier, _ fields: [VariableDeclNode]) {
        self.name = name
        self.fields = fields
    }

    func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitStructDecl(self, context)
    }
}

// MARK: - VariableDeclNode

final class VariableDeclNode: SyntaxNode {
    func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitVariableDecl(self, context)
    }
}

// MARK: - TypeNode

final class TypeNode: SyntaxNode {
    func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitType(self, context)
    }
}
