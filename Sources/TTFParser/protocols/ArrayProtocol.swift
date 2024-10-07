// Copyright 2024 Lie Yan

import Foundation

protocol ArrayProtocol {
    associatedtype Element

    var count: Int { get }
    subscript(index: Int) -> Element? { get }
}
