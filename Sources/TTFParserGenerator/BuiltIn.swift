// Copyright 2024 satzlich

import Foundation

enum BuiltIn {
    static let uint8 = SimpleType("uint8")!
    static let int8 = SimpleType("int8")!
    static let uint16 = SimpleType("uint16")!
    static let int16 = SimpleType("int16")!
    static let uint24 = SimpleType("uint24")!
    static let uint32 = SimpleType("uint32")!
    static let int32 = SimpleType("int32")!
    static let Fixed = SimpleType("Fixed")!
    static let FWORD = SimpleType("FWORD")!
    static let UFWORD = SimpleType("UFWORD")!
    static let F2DOT14 = SimpleType("F2DOT14")!
    static let LONGDATETIME = SimpleType("LONGDATETIME")!
    static let Tag = SimpleType("Tag")!
    static let Offset8 = SimpleType("Offset8")!
    static let Offset16 = SimpleType("Offset16")!
    static let Offset24 = SimpleType("Offset24")!
    static let Offset32 = SimpleType("Offset32")!
    static let Version16Dot16 = SimpleType("Version16Dot16")!

    static let typeProperties: [SimpleType: TypeProperty] =
        [
            uint8: TypeProperty(encodingSize: 1),
            int8: TypeProperty(encodingSize: 1),
            uint16: TypeProperty(encodingSize: 2),
            int16: TypeProperty(encodingSize: 2),
            uint24: TypeProperty(encodingSize: 3),
            uint32: TypeProperty(encodingSize: 4),
            int32: TypeProperty(encodingSize: 4),
            Fixed: TypeProperty(encodingSize: 8),
            FWORD: TypeProperty(encodingSize: 2),
            UFWORD: TypeProperty(encodingSize: 2),
            F2DOT14: TypeProperty(encodingSize: 2),
            LONGDATETIME: TypeProperty(encodingSize: 8),
            Tag: TypeProperty(encodingSize: 4),
            Offset8: TypeProperty(encodingSize: 1),
            Offset16: TypeProperty(encodingSize: 2),
            Offset24: TypeProperty(encodingSize: 3),
            Offset32: TypeProperty(encodingSize: 4),
            Version16Dot16: TypeProperty(encodingSize: 4),
        ]

    static let types: [SimpleType] = typeProperties.keys.map { $0 }

    // MARK: - TypeProperty

    struct TypeProperty {
        let encodingSize: Int

        init(encodingSize: Int) {
            self.encodingSize = encodingSize
        }
    }
}
