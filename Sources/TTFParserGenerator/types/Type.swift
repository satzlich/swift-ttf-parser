// Copyright 2024 Lie Yan

import Foundation

// MARK: - `Type`

/**
 A concrete (that is, free of un-specified type parameter) type used in the system.

 */
public enum `Type` {
    case SimpleType(SimpleType)
    case SpecializedArrayType(SpecializedArrayType)
}
