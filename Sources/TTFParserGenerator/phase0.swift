// Copyright 2024 satzlich

import Foundation

enum phase0 {
    struct StructDeclaration {
        let name: String
        var fields: [VariableDeclaration]

        init(
            name: String,
            fields: [VariableDeclaration]
        ) {
            self.name = name
            self.fields = fields
        }
    }

    struct VariableDeclaration {
        struct Annotation {
            //
        }

        var type: TypeReference
        let name: String
        let annotation: Annotation?

        init(
            type: TypeReference,
            name: String,
            annotation: Annotation? = nil
        ) {
            self.type = type
            self.name = name
            self.annotation = annotation
        }
    }

    enum TypeReference {
        case identifier(String)
        case array(element: String)

        func isArray() -> Bool {
            switch self {
            case .array:
                return true
            default:
                return false
            }
        }
    }
}

