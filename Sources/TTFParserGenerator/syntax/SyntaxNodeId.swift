// Copyright 2024 satzlich

import Foundation

public struct SyntaxNodeId: Equatable, Hashable, CustomStringConvertible, CustomDebugStringConvertible {
    public let id: String

    public init(_ id: String) {
        self.id = id
    }

    public var description: String {
        self.id
    }

    public var debugDescription: String {
        self.id
    }
}
