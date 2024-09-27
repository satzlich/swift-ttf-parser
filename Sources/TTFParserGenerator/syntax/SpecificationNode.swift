// Copyright 2024 satzlich

import Foundation

final class SpecificationNode: SyntaxNode {
    let structDeclarations: [StructDeclNode]
    
    init(_ structDeclarations: [StructDeclNode]) {
        self.structDeclarations = structDeclarations
    }
    
    var children: [any SyntaxNode] {
        self.structDeclarations
    }
    
    func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitSpecification(self, context)
    }
}
