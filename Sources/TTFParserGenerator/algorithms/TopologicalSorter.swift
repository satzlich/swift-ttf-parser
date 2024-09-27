// Copyright 2024 satzlich

import Algorithms
import Foundation

struct TopologicalSorter<T>
    where T: Equatable & Hashable
{
    /// Return true if the graph is valid, that is, all nodes used in `edges` are
    /// in `vertices`.
    ///
    /// - Note: Edge `a → b` is given by `(a, b)`.
    ///
    /// - Complexity: O(n + m)
    static func validate(_ vertices: [T], _ edges: [(T, T)]) -> Bool {
        let edgeProjection = edges.flatMap { [$0.0, $0.1] }.uniqued()
        return Set(vertices).isSuperset(of: edgeProjection)
    }

    /// Sort nodes topologically.
    ///
    /// - Returns: A list of nodes sorted topologically if the graph is acyclic.
    ///
    /// - Complexity: O(n + m)
    static func sort(_ vertices: [T], _ edges: [(T, T)]) -> [T]? {
        precondition(self.validate(vertices, edges))

        return []
    }
}
