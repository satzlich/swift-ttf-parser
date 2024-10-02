// Copyright 2024 Lie Yan

extension CoverageTable {
    public struct Format1: SafeDecodable {
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
            guard bytes.count >= Self.minWidth else {
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

        static var minWidth: Int = Offsets.glyphArray

        static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> CoverageTable.Format1? {
            Format1(bytes)
        }

        subscript(_ glyphId: UInt16) -> UInt16? {
            self.glyphArray.binarySearch(glyphId).map { UInt16($0.index) }
        }
    }
}
