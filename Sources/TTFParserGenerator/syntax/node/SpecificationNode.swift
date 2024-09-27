// Copyright 2024 satzlich

import Foundation

public final class SpecificationNode: SyntaxNode {
    public let structDeclarations: [StructDeclNode]

    public init(_ structDeclarations: [StructDeclNode]) {
        self.structDeclarations = structDeclarations
    }

    public var children: [any SyntaxNode] {
        self.structDeclarations
    }

    public func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitSpecification(self, context)
    }
}
