// Copyright 2024 satzlich

import Algorithms
import Foundation

public struct NodeDescriptionBuilder {
    private var string: String
    private var id: SyntaxNodeId?

    init() {
        self.string = ""
        self.id = nil
    }

    // MARK: - Named

    mutating func append(_ name: String, _ value: SyntaxNodeId) {
        if name == "id" {
            self.id = value
        }
        else {
            self.append(name, value.description)
        }
    }

    mutating func append(_ name: String, _ value: some CustomStringConvertible) {
        self.append(name, value.description)
    }

    mutating func appendArray<T: CustomStringConvertible>(_ name: String, _ array: [T]) {
        self.append(name, Self.formatArray(array))
    }

    private mutating func append(_ name: String, _ value: String) {
        self.string += "\(name): \(value), "
    }

    // MARK: - Unamed

    mutating func append(_ value: some CustomStringConvertible) {
        self.append(value.description)
    }

    mutating func appendArray<T: CustomStringConvertible>(_ array: [T]) {
        self.append(Self.formatArray(array))
    }

    private mutating func append(_ value: String) {
        self.string += "\(value), "
    }

    // MARK: - Format

    private static func formatArray<T: CustomStringConvertible>(_ array: [T]) -> String {
        "[\(array.map { $0.description }.joined(separator: ", "))]"
    }

    public func format(_ showId: Bool = false) -> String {
        let string =
            self.string.hasSuffix(", ") ? String(self.string.dropLast(2)) : self.string

        return if showId, let id = self.id {
            "<\(id)> \(string)"
        }
        else {
            string
        }
    }
}
