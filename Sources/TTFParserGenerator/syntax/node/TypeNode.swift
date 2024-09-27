// Copyright 2024 satzlich

import Foundation

// MARK: - TypeNode

public final class TypeNode: SyntaxNode {
    public let id: SyntaxNodeId

    public let type: `Type`

    public init(_ id: SyntaxNodeId, _ variant: `Type`) {
        self.id = id
        self.type = variant
    }

    public convenience init(_ id: SyntaxNodeId, _ simpleType: SimpleType) {
        self.init(id, .SimpleType(simpleType))
    }

    public convenience init(_ id: SyntaxNodeId, _ specializedArrayType: SpecializedArrayType) {
        self.init(id, .SpecializedArrayType(specializedArrayType))
    }

    public var children: [any SyntaxNode] {
        []
    }

    public func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitType(self, context)
    }
}
