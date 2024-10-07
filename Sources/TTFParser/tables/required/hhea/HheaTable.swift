// Copyright 2024 Lie Yan

import Foundation

struct HheaTable: SafeDecodable {
    public var majorVersion: UInt16 {
        .decode(bytes + Offsets.majorVersion)
    }

    public var minorVersion: UInt16 {
        .decode(bytes + Offsets.minorVersion)
    }

    public var ascender: FWORD {
        .decode(bytes + Offsets.ascender)
    }

    public var descender: FWORD {
        .decode(bytes + Offsets.descender)
    }

    public var lineGap: FWORD {
        .decode(bytes + Offsets.lineGap)
    }

    public var advanceWidthMax: UFWORD {
        .decode(bytes + Offsets.advanceWidthMax)
    }

    public var minLeftSideBearing: FWORD {
        .decode(bytes + Offsets.minLeftSideBearing)
    }

    public var minRightSideBearing: FWORD {
        .decode(bytes + Offsets.minRightSideBearing)
    }

    public var xMaxExtent: FWORD {
        .decode(bytes + Offsets.xMaxExtent)
    }

    public var caretSlopeRise: Int16 {
        .decode(bytes + Offsets.caretSlopeRise)
    }

    public var caretSlopeRun: Int16 {
        .decode(bytes + Offsets.caretSlopeRun)
    }

    public var caretOffset: Int16 {
        .decode(bytes + Offsets.caretOffset)
    }

    public var reserved0: Int16 {
        .decode(bytes + Offsets.reserved0)
    }

    public var reserved1: Int16 {
        .decode(bytes + Offsets.reserved1)
    }

    public var reserved2: Int16 {
        .decode(bytes + Offsets.reserved2)
    }

    public var reserved3: Int16 {
        .decode(bytes + Offsets.reserved3)
    }

    public var metricDataFormat: Int16 {
        .decode(bytes + Offsets.metricDataFormat)
    }

    public var numberOfHMetrics: UInt16 {
        .decode(bytes + Offsets.numberOfHMetrics)
    }

    private enum Offsets {
        static let majorVersion = 0
        static let minorVersion = majorVersion + UInt16.encodingWidth
        static let ascender = minorVersion + UInt16.encodingWidth
        static let descender = ascender + FWORD.encodingWidth
        static let lineGap = descender + FWORD.encodingWidth
        static let advanceWidthMax = lineGap + FWORD.encodingWidth
        static let minLeftSideBearing = advanceWidthMax + UFWORD.encodingWidth
        static let minRightSideBearing = minLeftSideBearing + FWORD.encodingWidth
        static let xMaxExtent = minRightSideBearing + FWORD.encodingWidth
        static let caretSlopeRise = xMaxExtent + FWORD.encodingWidth
        static let caretSlopeRun = caretSlopeRise + Int16.encodingWidth
        static let caretOffset = caretSlopeRun + Int16.encodingWidth
        static let reserved0 = caretOffset + Int16.encodingWidth
        static let reserved1 = reserved0 + Int16.encodingWidth
        static let reserved2 = reserved1 + Int16.encodingWidth
        static let reserved3 = reserved2 + Int16.encodingWidth
        static let metricDataFormat = reserved3 + Int16.encodingWidth
        static let numberOfHMetrics = metricDataFormat + Int16.encodingWidth
    }

    private let bytes: UnsafePointer<UInt8>

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= HheaTable.minWidth else {
            return nil
        }

        let majorVersion = UInt16.decode(bytes.baseAddress! + Offsets.majorVersion)
        let minorVersion = UInt16.decode(bytes.baseAddress! + Offsets.minorVersion)

        guard
            majorVersion == 1,
            minorVersion == 0
        else {
            return nil
        }

        self.bytes = bytes.baseAddress!
    }

    static var minWidth: Int {
        Offsets.numberOfHMetrics + UInt16.encodingWidth
    }

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> HheaTable? {
        HheaTable(bytes)
    }
}
