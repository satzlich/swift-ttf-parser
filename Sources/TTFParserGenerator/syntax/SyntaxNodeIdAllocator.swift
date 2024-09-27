// Copyright 2024 satzlich

import Foundation

public final class SyntaxNodeIdAllocator: CustomStringConvertible {
    private var nextId: Int = 0

    public func getNextId() -> SyntaxNodeId {
        defer { nextId += 1 }
        return SyntaxNodeId("\(self.nextId)")
    }

    public var description: String {
        "nextId: \(self.nextId)"
    }
}
