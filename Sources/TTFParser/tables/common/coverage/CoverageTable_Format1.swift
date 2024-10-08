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

         Array length given by glyphCount.
         */
        public let glyphArray: FlatArray<UInt16>

        enum _Offsets {
            static let format = 0
            static let glyphCount = format + UInt16.encodingWidth
            static let glyphArray = glyphCount + UInt16.encodingWidth
        }

        private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
            guard bytes.count >= Self.minWidth else {
                return nil
            }

            self.format = UInt16.decode(bytes.baseAddress! + _Offsets.format)
            self.glyphCount = UInt16.decode(bytes.baseAddress! + _Offsets.glyphCount)

            do {
                let bytes = bytes.rebase(_Offsets.glyphArray)
                let count = Int(glyphCount)
                guard let glyphArray = FlatArray<UInt16>(bytes, count) else {
                    return nil
                }
                self.glyphArray = glyphArray
            }
        }

        public static let minWidth: Int = _Offsets.glyphArray

        public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> CoverageTable.Format1? {
            Format1(bytes)
        }

        public func contains(_ glyphId: UInt16) -> Bool {
            self.glyphArray.binarySearch(glyphId) != nil
        }

        public func get(_ glyphId: UInt16) -> UInt16? {
            self.glyphArray.binarySearch(glyphId).map { UInt16($0.index) }
        }
    }
}
