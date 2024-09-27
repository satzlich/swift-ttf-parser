// Copyright 2024 satzlich

import Foundation

// MARK: - AbstractType

protocol AbstractType { }

// MARK: - SimpleType

struct SimpleType: AbstractType {
    let name: Identifier

    init(_ name: Identifier) {
        self.name = name
    }

    init?(_ name: String) {
        self.init(Identifier(name))
    }
}

// MARK: - SpecializedArrayType

struct SpecializedArrayType: AbstractType {
    let elementType: SimpleType

    init(_ elementType: SimpleType) {
        self.elementType = elementType
    }
}

// MARK: - PrimitiveType

struct PrimitiveType: AbstractType, Equatable, Hashable {
    let name: Identifier

    init(_ name: Identifier) {
        self.name = name
    }

    init?(_ name: String) {
        self.init(Identifier(name))
    }

    static func == (lhs: PrimitiveType, rhs: PrimitiveType) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
    }
}

// MARK: - PrimitiveTypeProperty

struct PrimitiveTypeProperty {
    let encodingSize: Int

    init(encodingSize: Int) {
        self.encodingSize = encodingSize
    }
}
