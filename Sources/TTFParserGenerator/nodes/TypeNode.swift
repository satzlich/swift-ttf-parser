// Copyright 2024 satzlich

import Foundation

// MARK: - TypeNode

final class TypeNode: SyntaxNode {
    let variant: TypeVariant

    init(_ variant: TypeVariant) {
        self.variant = variant
    }

    init(_ simpleType: SimpleType) {
        self.variant = .SimpleType(simpleType)
    }

    init(_ specializedArray: SpecializedArrayType) {
        self.variant = .SpecializedArrayType(specializedArray)
    }

    var children: [any SyntaxNode] {
        []
    }

    func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitType(self, context)
    }
}
