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
        self.descriptionBuilder.build(false)
    }

    public var debugDescription: String {
        self.descriptionBuilder.build(true)
    }

    private var descriptionBuilder: ProvisionalStringBuilder {
        var builder = ProvisionalStringBuilder()

        builder.append("id", self.id)
        builder.append(self.variableDecl.description)

        return builder
    }
}
