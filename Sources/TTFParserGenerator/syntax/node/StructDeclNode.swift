// Copyright 2024 Lie Yan

import Foundation

// MARK: - StructDeclNode

public final class StructDeclNode: SyntaxNode {
    public let id: SyntaxNodeId

    public let name: Identifier
    public let members: [StructMemberNode]

    public init(_ id: SyntaxNodeId, _ name: Identifier, _ members: [StructMemberNode]) {
        self.id = id
        self.name = name
        self.members = members
    }

    public var children: [any SyntaxNode] {
        self.members
    }

    public func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitStructDecl(self, context)
    }
}
