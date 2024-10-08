// Copyright 2024 Lie Yan

import Foundation

public struct LongHorMetric: FixedDecodable {
    public let advanceWidth: UFWORD
    public let leftSideBearing: FWORD

    private enum Offsets {
        static let advanceWidth = 0
        static let lsb = advanceWidth + UFWORD.encodingWidth
    }

    private init(_ bytes: UnsafePointer<UInt8>) {
        self.advanceWidth = UFWORD.decode(bytes + Offsets.advanceWidth)
        self.leftSideBearing = FWORD.decode(bytes + Offsets.lsb)
    }

    public static var encodingWidth: Int {
        Offsets.lsb + FWORD.encodingWidth
    }

    public static func decode(_ bytes: UnsafePointer<UInt8>) -> LongHorMetric {
        LongHorMetric(bytes)
    }
}
