// Copyright 2024 satzlich

import Foundation

/// Pass 0: translation from Antlr
enum Repr<Annotation> {
    // MARK: - StructDeclaration

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

    enum TypeReference {
        case identifier(TypeIdentifier)
        case array(element: TypeIdentifier)

        func isArray() -> Bool {
            switch self {
            case .array:
                return true
            default:
                return false
            }
        }
    }

    typealias TypeIdentifier = Identifier

    // MARK: - Identifier

    final class Identifier {
        let name: String

        init(name: String) {
            self.name = name
        }

        init(_ identifier: Identifier) {
            self.name = identifier.name
        }
    }
}
