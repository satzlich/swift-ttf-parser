// Copyright 2024 Lie Yan

extension CoverageTable {
    public struct Format2: SafeDecodable {
        public let format: UInt16
        public let rangeCount: UInt16

        /**
         Array of glyph ranges — ordered by startGlyphID.

         Array length given by rangeCount.
         */
        public let rangeRecords: FlatArray<RangeRecord>

        private enum Offsets {
            static let format = 0
            static let rangeCount = format + UInt16.encodingWidth
            static let rangeRecords = rangeCount + UInt16.encodingWidth
        }

        private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
            guard bytes.count >= Self.minWidth else {
                return nil
            }

            self.format = UInt16.decode(bytes.baseAddress! + Offsets.format)
            self.rangeCount = UInt16.decode(bytes.baseAddress! + Offsets.rangeCount)

            do {
                let bytes = bytes.rebase(Offsets.rangeRecords)
                let count = Int(self.rangeCount)
                guard let rangeRecords = FlatArray<RangeRecord>(bytes, count) else {
                    return nil
                }
                self.rangeRecords = rangeRecords
            }
        }

        public static let minWidth: Int = Offsets.rangeRecords

        public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> CoverageTable.Format2? {
            Format2(bytes)
        }

        public func contains(_ glyphId: UInt16) -> Bool {
            rangeRecords.binarySearch(glyphId) { $0.compare($1) } != nil
        }

        public func get(_ glyphId: UInt16) -> UInt16? {
            let range = rangeRecords.binarySearch(glyphId) { $0.compare($1) }?.value
            guard let range else {
                return nil
            }

            return range.startCoverageIndex + glyphId - range.startGlyphID
        }
    }
}
