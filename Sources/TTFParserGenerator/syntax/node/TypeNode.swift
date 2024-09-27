// Copyright 2024 satzlich

import Foundation

// MARK: - TypeNode

public final class TypeNode: SyntaxNode {
    public let variant: TypeVariant

    public init(_ variant: TypeVariant) {
        self.variant = variant
    }

    public init(_ simpleType: SimpleType) {
        self.variant = .SimpleType(simpleType)
    }

    public init(_ specializedArrayType: SpecializedArrayType) {
        self.variant = .SpecializedArrayType(specializedArrayType)
    }

    public var children: [any SyntaxNode] {
        []
    }

    public func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitType(self, context)
    }
}
