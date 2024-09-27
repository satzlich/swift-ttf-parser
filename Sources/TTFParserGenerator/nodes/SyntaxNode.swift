// Copyright 2024 satzlich

import Foundation

// MARK: - SyntaxNode

protocol SyntaxNode: AnyObject {
    var children: [SyntaxNode] { get }

    func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R
}
