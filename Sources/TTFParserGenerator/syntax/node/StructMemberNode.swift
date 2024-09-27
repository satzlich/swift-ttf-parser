// Copyright 2024 satzlich

import Foundation

public final class StructMemberNode: SyntaxNode {
    public let id: SyntaxNodeId
    public let variableDecl: VariableDeclNode

    public init(_ id: SyntaxNodeId, _ variableDecl: VariableDeclNode) {
        self.id = id
        self.variableDecl = variableDecl
    }

    public var children: [any SyntaxNode] {
        [self.variableDecl]
    }

    public func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitStructMember(self, context)
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
        builder.append(self.variableDecl.description)

        return builder
    }
}
