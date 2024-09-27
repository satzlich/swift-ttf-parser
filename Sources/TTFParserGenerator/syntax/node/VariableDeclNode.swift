// Copyright 2024 satzlich

import Foundation

// MARK: - VariableDeclNode

public final class VariableDeclNode: SyntaxNode {
    public let id: SyntaxNodeId
    public let name: Identifier
    public let type: TypeNode

    public init(_ id: SyntaxNodeId, _ name: Identifier, _ type: TypeNode) {
        self.id = id
        self.name = name
        self.type = type
    }

    public var children: [any SyntaxNode] {
        [self.type]
    }

    public func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitVariableDecl(self, context)
    }

    public var description: String {
        var formatter = NodeDescriptionFormatter()

        formatter.addField("id", self.id)
        formatter.addField("name", self.name)
        formatter.addField("type", self.type)

        return formatter.format()
    }
}
