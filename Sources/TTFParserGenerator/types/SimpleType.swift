// Copyright 2024 Lie Yan

import Foundation

// MARK: - SimpleType

public struct SimpleType: Equatable, Hashable {
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
}
