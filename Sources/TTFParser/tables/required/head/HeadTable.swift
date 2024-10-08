// Copyright 2024 Lie Yan

import Foundation

public struct HeadTable: SafeDecodable {
    public var majorVersion: UInt16 {
        .decode(bytes + Offsets.majorVersion)
    }

    public var minorVersion: UInt16 {
        .decode(bytes + Offsets.minorVersion)
    }

    public var fontRevision: UInt32 {
        .decode(bytes + Offsets.fontRevision)
    }

    public var checkSumAdjustment: UInt32 {
        .decode(bytes + Offsets.checkSumAdjustment)
    }

    public var magicNumber: UInt32 {
        .decode(bytes + Offsets.magicNumber)
    }

    public var flags: UInt16 {
        .decode(bytes + Offsets.flags)
    }

    public var unitsPerEm: UInt16 {
        .decode(bytes + Offsets.unitsPerEm)
    }

    public var created: LONGDATETIME {
        .decode(bytes + Offsets.created)
    }

    public var modified: LONGDATETIME {
        .decode(bytes + Offsets.modified)
    }

    public var xMin: Int16 {
        .decode(bytes + Offsets.xMin)
    }

    public var yMin: Int16 {
        .decode(bytes + Offsets.yMin)
    }

    public var xMax: Int16 {
        .decode(bytes + Offsets.xMax)
    }

    public var yMax: Int16 {
        .decode(bytes + Offsets.yMax)
    }

    public var macStyle: UInt16 {
        .decode(bytes + Offsets.macStyle)
    }

    public var lowestRecPPEM: UInt16 {
        .decode(bytes + Offsets.lowestRecPPEM)
    }

    public var fontDirectionHint: Int16 {
        .decode(bytes + Offsets.fontDirectionHint)
    }

    public var indexToLocFormat: Int16 {
        .decode(bytes + Offsets.indexToLocFormat)
    }

    public var glyphDataFormat: Int16 {
        .decode(bytes + Offsets.glyphDataFormat)
    }

    private enum Offsets {
        static let majorVersion = 0
        static let minorVersion = majorVersion + UInt16.encodingWidth
        static let fontRevision = minorVersion + UInt16.encodingWidth
        static let checkSumAdjustment = fontRevision + UInt32.encodingWidth
        static let magicNumber = checkSumAdjustment + UInt32.encodingWidth
        static let flags = magicNumber + UInt32.encodingWidth
        static let unitsPerEm = flags + UInt16.encodingWidth
        static let created = unitsPerEm + UInt16.encodingWidth
        static let modified = created + LONGDATETIME.encodingWidth
        static let xMin = modified + LONGDATETIME.encodingWidth
        static let yMin = xMin + Int16.encodingWidth
        static let xMax = yMin + Int16.encodingWidth
        static let yMax = xMax + Int16.encodingWidth
        static let macStyle = yMax + Int16.encodingWidth
        static let lowestRecPPEM = macStyle + UInt16.encodingWidth
        static let fontDirectionHint = lowestRecPPEM + UInt16.encodingWidth
        static let indexToLocFormat = fontDirectionHint + Int16.encodingWidth
        static let glyphDataFormat = indexToLocFormat + Int16.encodingWidth
    }

    private let bytes: UnsafePointer<UInt8>

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= HeadTable.minWidth else {
            return nil
        }

        let majorVersion = UInt16.decode(bytes.baseAddress! + Offsets.majorVersion)
        let minorVersion = UInt16.decode(bytes.baseAddress! + Offsets.minorVersion)
        let magicNumber = UInt32.decode(bytes.baseAddress! + Offsets.magicNumber)

        guard
            majorVersion == 1,
            minorVersion == 0,
            magicNumber == 0x5F0F_3CF5
        else {
            return nil
        }
        self.bytes = bytes.baseAddress!
    }

    public static var minWidth: Int {
        Offsets.glyphDataFormat + Int16.encodingWidth
    }

    public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> HeadTable? {
        HeadTable(bytes)
    }
}
