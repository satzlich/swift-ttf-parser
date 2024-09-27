// Copyright 2024 satzlich

import Foundation

public final class StructMemberNode: SyntaxNode {
    public let variableDecl: VariableDeclNode

    public init(_ variableDecl: VariableDeclNode) {
        self.variableDecl = variableDecl
    }

    public var children: [any SyntaxNode] {
        [self.variableDecl]
    }

    public func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitStructMember(self, context)
    }
}
