// Copyright 2024 satzlich

import Foundation

final class SyntaxNodeIdAllocator {
    private var nextId: Int = 0

    public func getNextId() -> SyntaxNodeId {
        defer { nextId += 1 }
        return SyntaxNodeId("\(self.nextId)")
    }
}
