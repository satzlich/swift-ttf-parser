// Copyright 2024 Lie Yan

protocol OffsetProtocol {
    associatedtype RawValue

    var rawValue: RawValue { get }
    var isNull: Bool { get }
    func apply<R>(_ f: (Int) -> R?) -> R?
}
