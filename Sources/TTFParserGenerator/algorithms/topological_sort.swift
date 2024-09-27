// Copyright 2024 satzlich

import Foundation

struct TopologicalSorter<T>
    where T: Equatable & Hashable
{
    private struct Edge: Equatable, Hashable {
        let source: T
        let target: T

        init(_ source: T, _ target: T) {
            self.source = source
            self.target = target
        }
    }

    private var edges: Set<Edge>
    private var nodes: Set<T>

    init() {
        self.edges = Set()
        self.nodes = Set()
    }

    mutating func insert(_ source: T, _ target: T) {
        self.edges.insert(Edge(source, target))
        self.nodes.insert(source)
        self.nodes.insert(target)
    }

    mutating func insert(_ edge: (T, T)) {
        self.insert(edge.0, edge.1)
    }

    mutating func insert(contentsOf edges: [(T, T)]) {
        for edge in edges {
            self.insert(edge.0, edge.1)
        }
    }

    func sort() -> [T]? {
        []
    }
}
