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
}

// MARK: - SpecializedArrayType

struct SpecializedArrayType: AbstractType {
    let elementType: SimpleType

    init(_ elementType: SimpleType) {
        self.elementType = elementType
    }
}

// MARK: - PrimitiveType

struct PrimitiveType: AbstractType {
    let name: String
    let encodingSize: Int

    init(
        _ name: String,
        _ encodingSize: Int
    ) {
        self.name = name
        self.encodingSize = encodingSize
    }
}
