// Copyright 2024 Lie Yan

enum CoverageTable: VariantDecodable {
    case format1(Format1)
    case format2(Format2)

    private enum Offsets {
        static let format = Format1.Offsets.format
    }

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.leastWidth else {
            return nil
        }

        let baseAddress = bytes.baseAddress!

        let format = UInt16.decode(baseAddress + Offsets.format)

        switch format {
        case 1:
            guard let format1 = Format1.decode(bytes) else {
                return nil
            }
            self = .format1(format1)

        case 2:
            guard let format2 = Format2.decode(bytes) else {
                return nil
            }
            self = .format2(format2)

        case _:
            return nil
        }
    }

    static var leastWidth: Int {
        Swift.min(Format1.leastWidth, Format2.leastWidth)
    }

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> CoverageTable? {
        CoverageTable(bytes)
    }

    subscript(_ glyph: UInt16) -> UInt16? {
        switch self {
        case let .format1(format1):
            return format1[glyph]
        case let .format2(format2):
            return format2[glyph]
        }
    }
}
