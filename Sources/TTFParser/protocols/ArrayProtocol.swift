// Copyright 2024 Lie Yan

import Foundation

protocol ArrayProtocol {
    associatedtype Element

    var count: Int { get }
    func at(_ index: Int) -> Element?
}
