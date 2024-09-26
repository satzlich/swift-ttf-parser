// Copyright 2024 satzlich

import Foundation

enum phase1 {
    struct SizeBound {
        var upper: Int?
        var lower: Int?
    }

    struct ComputedAnnotation {
        var isFixedDecodable: Bool?
        var encodingSize: Int?
        var sizeBound: SizeBound
    }
}
