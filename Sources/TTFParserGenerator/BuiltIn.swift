// Copyright 2024 Lie Yan

import Foundation

public enum BuiltIn {
    public static let uint8 = SimpleType("uint8")!
    public static let int8 = SimpleType("int8")!
    public static let uint16 = SimpleType("uint16")!
    public static let int16 = SimpleType("int16")!
    public static let uint24 = SimpleType("uint24")!
    public static let uint32 = SimpleType("uint32")!
    public static let int32 = SimpleType("int32")!
    public static let Fixed = SimpleType("Fixed")!
    public static let FWORD = SimpleType("FWORD")!
    public static let UFWORD = SimpleType("UFWORD")!
    public static let F2DOT14 = SimpleType("F2DOT14")!
    public static let LONGDATETIME = SimpleType("LONGDATETIME")!
    public static let Tag = SimpleType("Tag")!
    public static let Offset8 = SimpleType("Offset8")!
    public static let Offset16 = SimpleType("Offset16")!
    public static let Offset24 = SimpleType("Offset24")!
    public static let Offset32 = SimpleType("Offset32")!
    public static let Version16Dot16 = SimpleType("Version16Dot16")!

    public static let typeProperties: [SimpleType: TypeProperty] =
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

    public static let types: [SimpleType] = typeProperties.keys.map { $0 }

    // MARK: - TypeProperty

    public struct TypeProperty {
        public let encodingSize: Int

        public init(encodingSize: Int) {
            self.encodingSize = encodingSize
        }
    }
}
