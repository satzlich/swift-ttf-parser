// Copyright 2024 satzlich

import Foundation
import SwiftSyntax

/// Extract a string literal from an expression
func getStringLiteral(_ expr: ExprSyntax) -> String? {
    guard let segments = expr.as(StringLiteralExprSyntax.self)?.segments,
          segments.count == 1,
          case let .stringSegment(string)? = segments.first
    else {
        return nil
    }
    return string.content.text
}
