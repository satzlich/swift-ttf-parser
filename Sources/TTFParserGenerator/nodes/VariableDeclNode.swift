// Copyright 2024 satzlich

import Foundation

// MARK: - VariableDeclNode

final class VariableDeclNode: SyntaxNode {
    let name: Identifier
    let type: TypeNode

    init(_ name: Identifier, _ type: TypeNode) {
        self.name = name
        self.type = type
    }

    var children: [any SyntaxNode] {
        [self.type]
    }

    func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitVariableDecl(self, context)
    }
}
