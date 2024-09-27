// Copyright 2024 satzlich

import Foundation

// MARK: - StructDeclNode

final class StructDeclNode: SyntaxNode {
    let name: Identifier
    let members: [StructMemberNode]

    init(_ name: Identifier, _ members: [StructMemberNode]) {
        self.name = name
        self.members = members
    }

    var children: [any SyntaxNode] {
        self.members
    }

    func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitStructDecl(self, context)
    }
}
