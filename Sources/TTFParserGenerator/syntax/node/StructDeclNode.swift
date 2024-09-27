// Copyright 2024 satzlich

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

    public var description: String {
        self.descriptionBuilder.build(false)
    }

    public var debugDescription: String {
        self.descriptionBuilder.build(true)
    }

    private var descriptionBuilder: ProvisionalStringBuilder {
        var builder = ProvisionalStringBuilder()

        builder.append("id", self.id)

        builder.append(
            "struct \(self.name) { "
                + self.members.map { $0.description }.joined(separator: " ")
                + " }"
        )

        return builder
    }
}
