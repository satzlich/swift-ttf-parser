// Copyright 2024 satzlich

import Foundation

// MARK: - SpecializedArrayType

public struct SpecializedArrayType: Equatable, Hashable {
    public let elementType: SimpleType

    public init(_ elementType: SimpleType) {
        self.elementType = elementType
    }
}
