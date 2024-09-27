// Copyright 2024 satzlich

import Foundation

// MARK: - AbstractType

protocol AbstractType { }

// MARK: - SimpleType

struct SimpleType: AbstractType, Equatable, Hashable {
    let name: Identifier

    init(_ name: Identifier) {
        self.name = name
    }

    init?(_ name: String) {
        guard let name = Identifier(name) else {
            return nil
        }
        self.init(name)
    }

    static func == (lhs: SimpleType, rhs: SimpleType) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
    }
}

// MARK: - SpecializedArrayType

struct SpecializedArrayType: AbstractType {
    let elementType: SimpleType

    init(_ elementType: SimpleType) {
        self.elementType = elementType
    }
}

// MARK: - TypeVariant

enum TypeVariant {
    case SimpleType(SimpleType)
    case SpecializedArrayType(SpecializedArrayType)
}
