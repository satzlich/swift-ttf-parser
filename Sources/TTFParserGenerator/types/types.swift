// Copyright 2024 satzlich

import Foundation

// MARK: - TypeProtocol

protocol TypeProtocol { }

// MARK: - SimpleType

struct SimpleType: TypeProtocol {
    let name: Identifier

    init(_ name: Identifier) {
        self.name = name
    }
}

// MARK: - SpecializedArray

struct SpecializedArray: TypeProtocol {
    let elementType: SimpleType

    init(_ elementType: SimpleType) {
        self.elementType = elementType
    }
}

// MARK: - PrimitiveType

struct PrimitiveType: TypeProtocol {
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
