// Copyright 2024 satzlich

import Foundation

// MARK: - TypeNode

final class TypeNode: SyntaxNode {
    enum Variant {
        case SimpleType(SimpleType)
        case SpecializedArray(SpecializedArray)
    }

    let variant: Variant

    init(_ variant: Variant) {
        self.variant = variant
    }

    init(_ simpleType: SimpleType) {
        self.variant = .SimpleType(simpleType)
    }

    init(_ specializedArray: SpecializedArray) {
        self.variant = .SpecializedArray(specializedArray)
    }

    var children: [any SyntaxNode] {
        []
    }

    func accept<R, C>(_ visitor: SyntaxVisitor<R, C>, _ context: C) -> R {
        visitor.visitType(self, context)
    }
}

