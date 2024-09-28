// Copyright 2024 Lie Yan

import Foundation

public final class SyntaxNodeIdAllocator {
    private var nextId: Int = 0

    public func getNextId() -> SyntaxNodeId {
        defer { nextId += 1 }
        return SyntaxNodeId("\(self.nextId)")
    }
}
