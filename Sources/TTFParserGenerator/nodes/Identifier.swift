// Copyright 2024 satzlich

import Foundation

// MARK: - Identifier

final class Identifier: Equatable, Hashable {
    let string: String

    init?(_ string: String) {
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
