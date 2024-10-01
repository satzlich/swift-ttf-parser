// Copyright 2024 Lie Yan

protocol OffsetProtocol {
    var isNull: Bool { get }

    func apply<R>(_ f: (Int) -> R) -> R?
    func apply<R>(_ f: (Int) -> R?) -> R?
}
