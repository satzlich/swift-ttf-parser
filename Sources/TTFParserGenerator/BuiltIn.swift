// Copyright 2024 satzlich

import Foundation

enum BuiltIn {
    static let uint8 = PrimitiveType("uint8")!
    static let int8 = PrimitiveType("int8")!
    static let uint16 = PrimitiveType("uint16")!
    static let int16 = PrimitiveType("int16")!
    static let uint24 = PrimitiveType("uint24")!
    static let uint32 = PrimitiveType("uint32")!
    static let int32 = PrimitiveType("int32")!
    static let Fixed = PrimitiveType("Fixed")!
    static let FWORD = PrimitiveType("FWORD")!
    static let UFWORD = PrimitiveType("UFWORD")!
    static let F2DOT14 = PrimitiveType("F2DOT14")!
    static let LONGDATETIME = PrimitiveType("LONGDATETIME")!
    static let Tag = PrimitiveType("Tag")!
    static let Offset8 = PrimitiveType("Offset8")!
    static let Offset16 = PrimitiveType("Offset16")!
    static let Offset24 = PrimitiveType("Offset24")!
    static let Offset32 = PrimitiveType("Offset32")!
    static let Version16Dot16 = PrimitiveType("Version16Dot16")!

    static let primitiveTypeProperties: [PrimitiveType: PrimitiveTypeProperty] =
        [
            uint8: PrimitiveTypeProperty(encodingSize: 1),
            int8: PrimitiveTypeProperty(encodingSize: 1),
            uint16: PrimitiveTypeProperty(encodingSize: 2),
            int16: PrimitiveTypeProperty(encodingSize: 2),
            uint24: PrimitiveTypeProperty(encodingSize: 3),
            uint32: PrimitiveTypeProperty(encodingSize: 4),
            int32: PrimitiveTypeProperty(encodingSize: 4),
            Fixed: PrimitiveTypeProperty(encodingSize: 8),
            FWORD: PrimitiveTypeProperty(encodingSize: 2),
            UFWORD: PrimitiveTypeProperty(encodingSize: 2),
            F2DOT14: PrimitiveTypeProperty(encodingSize: 2),
            LONGDATETIME: PrimitiveTypeProperty(encodingSize: 8),
            Tag: PrimitiveTypeProperty(encodingSize: 4),
            Offset8: PrimitiveTypeProperty(encodingSize: 1),
            Offset16: PrimitiveTypeProperty(encodingSize: 2),
            Offset24: PrimitiveTypeProperty(encodingSize: 3),
            Offset32: PrimitiveTypeProperty(encodingSize: 4),
            Version16Dot16: PrimitiveTypeProperty(encodingSize: 4),
        ]

    static let primitiveTypes: [PrimitiveType] = primitiveTypeProperties.keys.map { $0 }
}
