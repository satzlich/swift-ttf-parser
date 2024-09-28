// Copyright 2024 Lie Yan

import Foundation

// MARK: - SyntaxNode

public protocol SyntaxNode: AnyObject {
    var id: SyntaxNodeId { get }
    var children: [SyntaxNode] { get }

    func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R
}
