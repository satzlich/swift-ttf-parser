// Copyright 2024 satzlich

import Foundation

final class StructMemberNode: SyntaxNode {
    let variableDecl: VariableDeclNode
    
    init(_ variableDecl: VariableDeclNode) {
        self.variableDecl = variableDecl
    }
    
    var children: [any SyntaxNode] {
        [variableDecl]
    }
    
    func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitStructMember(self, context)
    }
}
