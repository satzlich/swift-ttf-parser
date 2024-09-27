// Copyright 2024 satzlich

import Foundation

class SimpleSyntaxVisitor<C: AnyObject>: SyntaxVisitor<Void, C> {
    override func visitSyntax(_ syntax: any SyntaxNode, _ context: C) {
        for child in syntax.children {
            child.accept(self, context)
        }
    }
}
