// Copyright 2024 satzlich

import Foundation

struct SizeBound {
    var upper: Int?
    var lower: Int?
}

struct DataType {
    let name: String

    var isFixedDecodable: Bool?
    /// Exact encoding size
    var encodingSize: Int?
    /// Size bound of the convex hull of reachable regions
    var sizeBound: SizeBound

    init(
        name: String,
        isFixedDecodable: Bool? = nil,
        encodingSize: Int? = nil,
        sizeBound: SizeBound
    ) {
        self.name = name
        self.isFixedDecodable = isFixedDecodable
        self.encodingSize = encodingSize
        self.sizeBound = sizeBound
    }
}

struct FixedDecodableProperty {
    let encodingSize: Int
}

/// Init a primitive type
private func pt(_ name: String, encodingSize: Int) -> DataType {
    DataType(
        name: name,
        isFixedDecodable: true,
        encodingSize: encodingSize,
        sizeBound: SizeBound(upper: encodingSize, lower: encodingSize)
    )
}

let PRIMITIVE_TYPES: [DataType] = [
    pt("uint8", encodingSize: 1),
    pt("int8", encodingSize: 1),
    pt("uint16", encodingSize: 2),
    pt("int16", encodingSize: 2),
    pt("uint24", encodingSize: 3),
    pt("uint32", encodingSize: 4),
    pt("int32", encodingSize: 4),
    pt("Fixed", encodingSize: 8),
    pt("FWORD", encodingSize: 2),
    pt("UFWORD", encodingSize: 2),
    pt("F2DOT14", encodingSize: 2),
    pt("LONGDATETIME", encodingSize: 8),
    pt("Tag", encodingSize: 4),
    pt("Offset8", encodingSize: 1),
    pt("Offset16", encodingSize: 2),
    pt("Offset24", encodingSize: 3),
    pt("Offset32", encodingSize: 4),
    pt("Version16Dot16", encodingSize: 4),
]
