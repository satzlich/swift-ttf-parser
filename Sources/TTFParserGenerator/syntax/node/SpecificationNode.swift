// Copyright 2024 satzlich

import Foundation

public final class SpecificationNode: SyntaxNode {
    public let structDeclarations: [StructDeclNode]
    public let id: SyntaxNodeId

    public init(_ id: SyntaxNodeId, _ structDeclarations: [StructDeclNode]) {
        self.id = id
        self.structDeclarations = structDeclarations
    }

    public var children: [any SyntaxNode] {
        self.structDeclarations
    }

    public func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitSpecification(self, context)
    }

    public var description: String {
        self.descriptionBuilder.format(false)
    }

    public var debugDescription: String {
        self.descriptionBuilder.format(true)
    }

    private var descriptionBuilder: NodeDescriptionBuilder {
        var builder = NodeDescriptionBuilder()

        builder.append("id", self.id)
        builder.appendArray(self.structDeclarations)

        return builder
    }
}
