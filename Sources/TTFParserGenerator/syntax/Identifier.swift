// Copyright 2024 satzlich

import Foundation

// MARK: - Identifier

public final class Identifier: Equatable, Hashable {
    public let string: String

    /// - Note: Not all strings are valid identifiers.
    public init?(_ string: String) {
        self.string = string
    }

    public init(_ identifier: Identifier) {
        self.string = identifier.string
    }

    public static func == (lhs: Identifier, rhs: Identifier) -> Bool {
        lhs.string == rhs.string
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.string)
    }
}
