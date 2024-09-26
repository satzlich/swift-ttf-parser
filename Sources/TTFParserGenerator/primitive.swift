// Copyright 2024 satzlich

import Foundation

struct SizeBound {
    var upper: Int?
    var lower: Int?
}

struct ComputedTypeAnnotation {
    var isFixedDecodable: Bool?
    var encodingSize: Int?
    var sizeBound: SizeBound
}

struct FieldAnnotation {
    //
}

protocol DataTypeProtocol {
    var computedAnnotation: ComputedTypeAnnotation? { get }
}

indirect enum DataType {
    case primitive(PrimitiveType)
    case array(ArrayType)
    case structType(StructType)

    func isArray() -> Bool {
        switch self {
        case .array:
            return true
        default:
            return false
        }
    }
}

struct PrimitiveType: DataTypeProtocol {
    let name: String
    let computedAnnotation: ComputedTypeAnnotation?

    init(
        name: String,
        encodingSize: Int
    ) {
        self.name = name
        self.computedAnnotation = ComputedTypeAnnotation(
            isFixedDecodable: true,
            encodingSize: encodingSize,
            sizeBound: SizeBound(upper: encodingSize, lower: encodingSize)
        )
    }
}

struct ArrayType: DataTypeProtocol {
    let elementType: DataType
    var computedAnnotation: ComputedTypeAnnotation?

    init(elementType: DataType, computedAnnotation: ComputedTypeAnnotation? = nil) {
        precondition(!elementType.isArray())
        self.elementType = elementType
        self.computedAnnotation = computedAnnotation
    }
}

struct StructType: DataTypeProtocol {
    let name: String
    var computedAnnotation: ComputedTypeAnnotation?
    var fields: [StructField]

    init(
        name: String,
        fields: [StructField]
    ) {
        self.name = name
        self.computedAnnotation = nil
        self.fields = fields
    }
}

struct StructField {
    let name: String
    var type: DataTypeProtocol
    let annotation: FieldAnnotation?

    init(
        name: String,
        type: DataTypeProtocol,
        annotation: FieldAnnotation? = nil
    ) {
        self.name = name
        self.type = type
        self.annotation = annotation
    }
}

enum pts {
    static let uint8 = pt("uint8", 1)
    static let int8 = pt("int8", 1)
    static let uint16 = pt("uint16", 2)
    static let int16 = pt("int16", 2)
    static let uint24 = pt("uint24", 3)
    static let uint32 = pt("uint32", 4)
    static let int32 = pt("int32", 4)
    static let Fixed = pt("Fixed", 8)
    static let FWORD = pt("FWORD", 2)
    static let UFWORD = pt("UFWORD", 2)
    static let F2DOT14 = pt("F2DOT14", 2)
    static let LONGDATETIME = pt("LONGDATETIME", 8)
    static let Tag = pt("Tag", 4)
    static let Offset8 = pt("Offset8", 1)
    static let Offset16 = pt("Offset16", 2)
    static let Offset24 = pt("Offset24", 3)
    static let Offset32 = pt("Offset32", 4)
    static let Version16Dot16 = pt("Version16Dot16", 4)

    static let allCases = [
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

    /// Init a primitive type
    private static func pt(
        _ name: String,
        _ encodingSize: Int
    ) -> PrimitiveType {
        PrimitiveType(
            name: name,
            encodingSize: encodingSize
        )
    }
}
