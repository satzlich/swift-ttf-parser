// Copyright 2024 Lie Yan

import Foundation

// MARK: - Identifier

public struct Identifier: Equatable, Hashable {
    public let string: String

    /// - Note: Not all strings are valid identifiers.
    public init?(_ string: String) {
        self.string = string
    }
}
