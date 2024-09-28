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
            uint8: TypeProperty(encodingWidth: 1),
            int8: TypeProperty(encodingWidth: 1),
            uint16: TypeProperty(encodingWidth: 2),
            int16: TypeProperty(encodingWidth: 2),
            uint24: TypeProperty(encodingWidth: 3),
            uint32: TypeProperty(encodingWidth: 4),
            int32: TypeProperty(encodingWidth: 4),
            Fixed: TypeProperty(encodingWidth: 8),
            FWORD: TypeProperty(encodingWidth: 2),
            UFWORD: TypeProperty(encodingWidth: 2),
            F2DOT14: TypeProperty(encodingWidth: 2),
            LONGDATETIME: TypeProperty(encodingWidth: 8),
            Tag: TypeProperty(encodingWidth: 4),
            Offset8: TypeProperty(encodingWidth: 1),
            Offset16: TypeProperty(encodingWidth: 2),
            Offset24: TypeProperty(encodingWidth: 3),
            Offset32: TypeProperty(encodingWidth: 4),
            Version16Dot16: TypeProperty(encodingWidth: 4),
        ]

    public static let types: [SimpleType] = typeProperties.keys.map { $0 }

    // MARK: - TypeProperty

    public struct TypeProperty {
        public let encodingWidth: Int

        public init(encodingWidth: Int) {
            self.encodingWidth = encodingWidth
        }
    }
}
