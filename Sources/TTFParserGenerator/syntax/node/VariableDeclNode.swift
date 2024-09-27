// Copyright 2024 satzlich

import Foundation

// MARK: - VariableDeclNode

public final class VariableDeclNode: SyntaxNode {
    public let name: Identifier
    public let type: TypeNode

    public init(_ name: Identifier, _ type: TypeNode) {
        self.name = name
        self.type = type
    }

    public var children: [any SyntaxNode] {
        [self.type]
    }

    public func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitVariableDecl(self, context)
    }
}
