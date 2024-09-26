// Copyright 2024 satzlich

import Algorithms
import Collections
import Foundation

/// Pass 0: translation from Antlr
enum Pass0 {
    // MARK: - StructDeclaration

    final class StructDeclarations: Sequence {
        typealias Element = StructDeclaration

        var structs: [StructDeclaration]

        init(structs: [StructDeclaration]) {
            self.structs = structs
        }

        func makeIterator() -> AnyIterator<StructDeclaration> {
            return AnyIterator(self.structs.makeIterator())
        }
    }

    final class StructDeclaration {
        let name: StructName
        var fields: [VariableDeclaration]

        init(
            name: StructName,
            fields: [VariableDeclaration]
        ) {
            self.name = name
            self.fields = fields
        }
    }

    typealias StructName = Identifier

    // MARK: - VariableDeclaration

    final class VariableDeclaration {
        var type: TypeReference
        let name: VariableName

        init(
            type: TypeReference,
            name: VariableName
        ) {
            self.type = type
            self.name = name
        }
    }

    typealias VariableName = Identifier

    // MARK: - TypeReference

    enum TypeReference: Equatable, Hashable {
        case name(TypeName)
        case array(element: TypeName)

        func isArray() -> Bool {
            switch self {
            case .array:
                return true
            default:
                return false
            }
        }
    }

    typealias TypeName = Identifier

    // MARK: - Identifier

    final class Identifier: Equatable, Hashable {
        let name: String

        init(name: String) {
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
    }
}

extension Pass0.TypeName {
    func into() -> Pass0.TypeReference {
        .name(self)
    }
}

extension String {
    func into() -> Pass0.Identifier {
        return Pass0.Identifier(name: self)
    }
}

extension BuiltIn.PrimitiveType {
    func typeName() -> Pass0.TypeName {
        return self.name.into()
    }
}

extension Pass0.StructDeclaration {
    func typeName() -> Pass0.TypeName {
        return self.name
    }
}

enum Pass1 {
    struct ArraySpecialization {
        let elementType: Pass0.TypeReference
    }

    enum TypeDefinition {
        case primitive(BuiltIn.PrimitiveType)
        case array(ArraySpecialization)
        case struct_(Pass0.StructDeclaration)
    }

    struct TypeTable {
        typealias Map = [Pass0.TypeReference: Pass1.TypeDefinition]

        let _dict: Map

        subscript(type: Pass0.TypeReference) -> Pass1.TypeDefinition? {
            return self._dict[type]
        }
    }

    func computeTypeTable(_ structs: Pass0.StructDeclarations) -> TypeTable {
        var dict = TypeTable.Map()

        // add primitive
        for primitive in BuiltIn.allPrimitiveTypes {
            let typeRef: Pass0.TypeReference = primitive.typeName().into()

            guard dict[typeRef] == nil else {
                fatalError()
            }
            dict[typeRef] = .primitive(primitive)
        }

        // add structs
        for struct_ in structs {
            let typeRef: Pass0.TypeReference = struct_.typeName().into()

            guard dict[typeRef] == nil else {
                fatalError()
            }
            dict[typeRef] = .struct_(struct_)
        }

        return TypeTable(_dict: dict)
    }
}
