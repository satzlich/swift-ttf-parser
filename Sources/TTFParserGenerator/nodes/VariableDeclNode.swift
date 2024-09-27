// Copyright 2024 satzlich

import Foundation

// MARK: - VariableDeclNode

final class VariableDeclNode: SyntaxNode {
    let type: TypeNode
    let name: Identifier

    init(_ type: TypeNode, _ name: Identifier) {
        self.type = type
        self.name = name
    }

    var children: [any SyntaxNode] {
        [self.type]
    }

    func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitVariableDecl(self, context)
    }
}
