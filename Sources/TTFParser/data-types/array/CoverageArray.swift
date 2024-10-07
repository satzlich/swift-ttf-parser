// Copyright 2024 Lie Yan

import Foundation

struct CoverageArray<A: ArrayProtocol> {
    typealias Element = A.Element

    private let array: A
    private let coverage: CoverageTable

    init(_ array: A, _ coverage: CoverageTable) {
        self.array = array
        self.coverage = coverage
    }

    public var count: Int {
        array.count
    }

    func get(_ glyphId: UInt16) -> Element? {
        guard let index = coverage.get(glyphId) else {
            return nil
        }
        return array.get(Int(index))
    }
}
