// Copyright 2024 satzlich

import Foundation

enum BuiltIn {
    static let uint8 = PrimitiveType("uint8", 1)
    static let int8 = PrimitiveType("int8", 1)
    static let uint16 = PrimitiveType("uint16", 2)
    static let int16 = PrimitiveType("int16", 2)
    static let uint24 = PrimitiveType("uint24", 3)
    static let uint32 = PrimitiveType("uint32", 4)
    static let int32 = PrimitiveType("int32", 4)
    static let Fixed = PrimitiveType("Fixed", 8)
    static let FWORD = PrimitiveType("FWORD", 2)
    static let UFWORD = PrimitiveType("UFWORD", 2)
    static let F2DOT14 = PrimitiveType("F2DOT14", 2)
    static let LONGDATETIME = PrimitiveType("LONGDATETIME", 8)
    static let Tag = PrimitiveType("Tag", 4)
    static let Offset8 = PrimitiveType("Offset8", 1)
    static let Offset16 = PrimitiveType("Offset16", 2)
    static let Offset24 = PrimitiveType("Offset24", 3)
    static let Offset32 = PrimitiveType("Offset32", 4)
    static let Version16Dot16 = PrimitiveType("Version16Dot16", 4)

    static let allPrimitiveTypes = [
        uint8,
        int8,
        uint16,
        int16,
        uint24,
        uint32,
        int32,
        Fixed,
        FWORD,
        UFWORD,
        F2DOT14,
        LONGDATETIME,
        Tag,
        Offset8,
        Offset16,
        Offset24,
        Offset32,
        Version16Dot16,
    ]
}
