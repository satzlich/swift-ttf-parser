// Copyright 2024 satzlich

import Algorithms
import Collections
import Foundation

// MARK: - Visitor

class Visitor {
    func visit(_ struct: StructDeclaration) {
        `struct`.accept(self)
    }

    func visit(_ variable: VariableDeclaration) {
        variable.accept(self)
    }

    func visit(_ typeRef: TypeReference) {
        typeRef.accept(self)
    }
}

// MARK: - StructDeclaration

final class StructDeclaration {
    let name: Identifier
    var fields: [VariableDeclaration]

    init(
        name: Identifier,
        fields: [VariableDeclaration]
    ) {
        self.name = name
        self.fields = fields
    }

    func accept(_ visitor: Visitor) {
        for field in self.fields {
            visitor.visit(field)
        }
    }
}

// MARK: - VariableDeclaration

final class VariableDeclaration {
    var type: TypeReference
    let name: Identifier

    init(
        type: TypeReference,
        name: Identifier
    ) {
        self.type = type
        self.name = name
    }

    func accept(_ visitor: Visitor) {
        // do nothing
    }
}

// MARK: - TypeReference

enum TypeReference: Equatable, Hashable {
    case name(Identifier)
    case array(elementType: Identifier)

    func isArray() -> Bool {
        switch self {
        case .array:
            return true
        default:
            return false
        }
    }

    func accept(_ visitor: Visitor) {
        // do nothing
    }
}

// MARK: - Identifier

final class Identifier: Equatable, Hashable {
    let string: String

    init(_ string: String) {
        self.string = string
    }

    init(_ identifier: Identifier) {
        self.string = identifier.string
    }

    static func == (lhs: Identifier, rhs: Identifier) -> Bool {
        lhs.string == rhs.string
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.string)
    }
}

// MARK: - ArraySpecialization

struct ArraySpecialization {
    let elementType: Identifier

    init(_ elementType: Identifier) {
        self.elementType = elementType
    }
}

// MARK: - TypeDefinition

enum TypeDefinition {
    case primitive(BuiltIn.PrimitiveType)
    case array(ArraySpecialization)
    case struct_(StructDeclaration)
}

// MARK: - TypeTable

struct TypeTable {
    typealias Map = [TypeReference: TypeDefinition]

    let _dict: Map

    init(_ dict: Map) {
        self._dict = dict
    }

    subscript(type: TypeReference) -> TypeDefinition? {
        return self._dict[type]
    }
}

func computeTypeTable(_ structs: [StructDeclaration]) -> TypeTable {
    var dict = TypeTable.Map()

    let s1: [(Identifier, TypeDefinition)] = BuiltIn.allPrimitiveTypes.map {
        (Identifier($0.name), TypeDefinition.primitive($0))
    }

    let s2: [(Identifier, TypeDefinition)] = structs.map {
        ($0.name, TypeDefinition.struct_($0))
    }

    let chain1 = Algorithms.chain(s1, s2).map {
        name, type in (TypeReference.name(name), type)
    }

    let visitor = ArraySpecializationVisitor()
    structs.forEach { visitor.visit($0) }

    let chain2 = visitor.specializations.map { s in
        (TypeReference.array(elementType: s.elementType), TypeDefinition.array(s))
    }

    for (typeRef, typeDef) in Algorithms.chain(chain1, chain2) {
        guard dict[typeRef] == nil else {
            fatalError("Duplicate type definition: \(typeRef)")
        }

        dict[typeRef] = typeDef
    }

    return TypeTable(dict)
}

// MARK: - ArraySpecializationVisitor

final class ArraySpecializationVisitor: Visitor {
    private var elementTypes: [Identifier]

    var specializations: [ArraySpecialization] {
        return self.elementTypes
            .map { ArraySpecialization($0) }
    }

    override init() {
        self.elementTypes = []
        super.init()
    }

    override func visit(_ typeRef: TypeReference) {
        switch typeRef {
        case let .array(elementType):
            self.elementTypes.append(elementType)
        default:
            super.visit(typeRef)
        }
    }
}
