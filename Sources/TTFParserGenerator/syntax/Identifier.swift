// Copyright 2024 satzlich

import Foundation

// MARK: - Identifier

public struct Identifier: Equatable, Hashable, CustomStringConvertible {
    public let string: String

    /// - Note: Not all strings are valid identifiers.
    public init?(_ string: String) {
        self.string = string
    }

    public init(_ identifier: Identifier) {
        self.string = identifier.string
    }

    public var description: String {
        self.string
    }
}
