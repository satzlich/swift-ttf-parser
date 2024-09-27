// Copyright 2024 satzlich

import Foundation

open class SimpleSyntaxVisitor<C: AnyObject>: SyntaxVisitor<Void, C> {
    override open func visitSyntax(_ syntax: any SyntaxNode, _ context: C) {
        for child in syntax.children {
            child.accept(self, context)
        }
    }
}
