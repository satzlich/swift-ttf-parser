// Copyright 2024 Lie Yan

enum CoverageTable: VariantDecodable {
    case format1(Format1)
    case format2(Format2)

    public struct Format1: VariableDecodable {
        /**
         Format identifier — format = 1.
         */
        public let format: UInt16
        /**
         Number of glyphs in the glyph array.
         */
        public let glyphCount: UInt16
        /**
         Array of glyph IDs — in numerical order.

         Count given by ``glyphCount``.
         */
        public let glyphArray: FlatArray<UInt16>

        enum Offsets {
            static let format = 0
            static let glyphCount = format + UInt16.encodingWidth
            static let glyphArray = glyphCount + UInt16.encodingWidth
        }

        private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
            guard bytes.count >= Self.leastWidth else {
                return nil
            }

            let baseAddress = bytes.baseAddress!

            self.format = UInt16.decode(baseAddress + Offsets.format)
            self.glyphCount = UInt16.decode(baseAddress + Offsets.glyphCount)

            guard let glyphArray =
                FlatArray<UInt16>(
                    bytes.rebase(Offsets.glyphArray),
                    Int(self.glyphCount)
                )
            else {
                return nil
            }

            self.glyphArray = glyphArray
        }

        static var leastWidth: Int = Offsets.glyphArray

        static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> CoverageTable.Format1? {
            Format1(bytes)
        }
    }

    public struct Format2: VariantDecodable {
        public let format: UInt16
        public let rangeCount: UInt16

        /**
         Array of glyph ranges — ordered by startGlyphID.

         Count given by ``rangeCount``.
         */
        public let rangeRecords: FlatArray<RangeRecord>

        private enum Offsets {
            static let format = 0
            static let rangeCount = format + UInt16.encodingWidth
            static let rangeRecords = rangeCount + UInt16.encodingWidth
        }

        private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
            guard bytes.count >= Self.leastWidth else {
                return nil
            }

            let baseAddress = bytes.baseAddress!

            self.format = UInt16.decode(baseAddress + Offsets.format)
            self.rangeCount = UInt16.decode(baseAddress + Offsets.rangeCount)

            guard let rangeRecords =
                FlatArray<RangeRecord>(
                    bytes.rebase(Offsets.rangeRecords),
                    Int(self.rangeCount)
                )
            else {
                return nil
            }

            self.rangeRecords = rangeRecords
        }

        static var leastWidth: Int = Offsets.rangeRecords

        static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> CoverageTable.Format2? {
            Format2(bytes)
        }
    }

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
}
