// Copyright 2024 Lie Yan

import Foundation

extension Comparable {
    func compare(_ rhs: Self) -> ComparisonResult {
        if self < rhs {
            return .orderedAscending
        }
        else if self == rhs {
            return .orderedSame
        }
        else {
            return .orderedDescending
        }
    }
}
