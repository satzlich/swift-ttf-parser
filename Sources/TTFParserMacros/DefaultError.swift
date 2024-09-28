// Copyright 2024 Lie Yan

import Foundation

enum DefaultError: Error, CustomStringConvertible {
    case message(String)

    var description: String {
        switch self {
        case let .message(message):
            return message
        }
    }
}
