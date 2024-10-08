// Copyright 2024 Lie Yan

import Foundation

public struct CoverageArray<A: ArrayProtocol> {
    public typealias Element = A.Element

    private let array: A
    private let coverage: CoverageTable

    init(_ array: A, _ coverage: CoverageTable) {
        self.array = array
        self.coverage = coverage
    }

    public var count: Int {
        array.count
    }

    public func get(_ glyphId: UInt16) -> Element? {
        guard let index = coverage.get(glyphId) else {
            return nil
        }
        return array.at(Int(index))
    }
}
