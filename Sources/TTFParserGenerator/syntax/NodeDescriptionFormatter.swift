// Copyright 2024 satzlich

import Algorithms
import Foundation

struct NodeDescriptionFormatter {
    private var string: String
    private var id: SyntaxNodeId?

    init() {
        self.string = ""
        self.id = nil
    }

    mutating func addField(_ name: String, _ value: SyntaxNodeId) {
        if name == "id" {
            self.id = value
        }
        else {
            self.addField(name, value.description)
        }
    }

    mutating func addField(_ name: String, _ value: some CustomStringConvertible) {
        self.addField(name, value.description)
    }

    mutating func addField(_ name: String, _ value: String) {
        self.string += "\(name): \(value), "
    }

    mutating func addProse(_ value: String) {
        self.string += "\(value), "
    }

    func format() -> String {
        let string =
            self.string.hasSuffix(", ") ? String(self.string.dropLast(2)) : self.string

        return if let id = self.id {
            "<\(id)> \(string)"
        }
        else {
            string
        }
    }
}
