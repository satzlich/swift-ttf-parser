// Copyright 2024 satzlich

import Foundation

// MARK: - AbstractType

public protocol AbstractType { }

// MARK: - SimpleType

public struct SimpleType: AbstractType, Equatable, Hashable, CustomStringConvertible {
    public let name: Identifier

    public init(_ name: Identifier) {
        self.name = name
    }

    public init?(_ name: String) {
        guard let name = Identifier(name) else {
            return nil
        }
        self.init(name)
    }

    public static func == (lhs: SimpleType, rhs: SimpleType) -> Bool {
        lhs.name == rhs.name
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
    }

    public var description: String {
        self.name.description
    }
}

// MARK: - SpecializedArrayType

public struct SpecializedArrayType: AbstractType, CustomStringConvertible {
    public let elementType: SimpleType

    public init(_ elementType: SimpleType) {
        self.elementType = elementType
    }

    public var description: String {
        "\(self.elementType.description)[]"
    }
}

// MARK: - TypeVariant

public enum TypeVariant: CustomStringConvertible {
    case SimpleType(SimpleType)
    case SpecializedArrayType(SpecializedArrayType)

    public var description: String {
        switch self {
        case let .SimpleType(simpleType):
            return simpleType.description
        case let .SpecializedArrayType(specializedArrayType):
            return specializedArrayType.description
        }
    }
}
