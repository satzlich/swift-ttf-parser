// Copyright 2024 Lie Yan

import Foundation

public struct SyntaxNodeId: Equatable, Hashable {
    public let id: String

    public init(_ id: String) {
        self.id = id
    }
}
