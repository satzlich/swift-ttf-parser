// Copyright 2024 Lie Yan

extension CoverageTable {
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
}
