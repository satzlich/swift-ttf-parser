// Copyright 2024 satzlich

// MARK: - Offset

protocol Offset {
    associatedtype Base
    associatedtype RawValue: BinaryInteger

    var rawValue: RawValue { get }

    init(_ value: Base)
    func is_null() -> Bool
}

extension Offset {
    func is_null() -> Bool {
        rawValue == 0
    }
}
