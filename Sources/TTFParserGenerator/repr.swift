// Copyright 2024 satzlich

import Algorithms
import Collections
import Foundation

class Visitor {
    func visit(_ structs: StructDeclarations) {
        structs.accept(self)
    }

    func visit(_ struct: StructDeclaration) {
        `struct`.accept(self)
    }

    func visit(_ variable: VariableDeclaration) {
        variable.accept(self)
    }

    func visit(_ typeRef: TypeReference) {
        typeRef.accept(self)
    }

    func visit(_ typeName: TypeName) {
        typeName.accept(self)
    }
}

// MARK: - StructDeclaration

final class StructDeclarations: Sequence {
    typealias Element = StructDeclaration

    var structs: [StructDeclaration]

    init(_ structs: [StructDeclaration]) {
        self.structs = structs
    }

    func makeIterator() -> AnyIterator<StructDeclaration> {
        return AnyIterator(self.structs.makeIterator())
    }

    func accept(_ visitor: Visitor) {
        for struct_ in self.structs {
            visitor.visit(struct_)
        }
    }
}

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
    case name(TypeName)
    case array(elementType: TypeName)

    func isArray() -> Bool {
        switch self {
        case .array:
            return true
        default:
            return false
        }
    }

    func accept(_ visitor: Visitor) {
        switch self {
        case let .name(typeName):
            visitor.visit(typeName)
        case let .array(elementType):
            visitor.visit(elementType)
        }
    }
}

struct TypeName: Equatable, Hashable {
    let identifier: Identifier

    init(_ identifier: Identifier) {
        self.identifier = identifier
    }

    func into_TypeReference() -> TypeReference {
        TypeReference.name(self)
    }

    func accept(_ visitor: Visitor) {
        // do nothing
    }
}

// MARK: - Identifier

final class Identifier: Equatable, Hashable {
    let name: String

    init(_ name: String) {
        self.name = name
    }

    init(_ identifier: Identifier) {
        self.name = identifier.name
    }

    static func == (lhs: Identifier, rhs: Identifier) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
    }

    func into_TypeName() -> TypeName {
        TypeName(self)
    }
}

struct ArraySpecialization {
    let elementType: TypeName

    init(_ elementType: TypeName) {
        self.elementType = elementType
    }
}

enum TypeDefinition {
    case primitive(BuiltIn.PrimitiveType)
    case array(ArraySpecialization)
    case struct_(StructDeclaration)
}

struct TypeTable {
    typealias Map = [TypeReference: TypeDefinition]

    let _dict: Map

    subscript(type: TypeReference) -> TypeDefinition? {
        return self._dict[type]
    }
}

func computeTypeTable(_ structs: StructDeclarations) -> TypeTable {
    var dict = TypeTable.Map()

    // add primitive
    for primitive in BuiltIn.allPrimitiveTypes {
        let typeRef: TypeReference = .name(Identifier(primitive.name).into_TypeName())

        guard dict[typeRef] == nil else {
            fatalError()
        }
        dict[typeRef] = .primitive(primitive)
    }

    // add structs
    for struct_ in structs {
        let typeRef: TypeReference = .name(struct_.name.into_TypeName())

        guard dict[typeRef] == nil else {
            fatalError()
        }
        dict[typeRef] = .struct_(struct_)
    }

    // add arrays
    let visitor = ArraySpecializationVisitor()
    visitor.visit(structs)

    for specialization in visitor.result {
        let typeRef: TypeReference = .array(elementType: specialization.elementType)

        guard dict[typeRef] == nil else {
            fatalError()
        }
        dict[typeRef] = .array(specialization)
    }

    return TypeTable(_dict: dict)
}

final class ArraySpecializationVisitor: Visitor {
    var elementTypes: [TypeName]

    var result: [ArraySpecialization] {
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
