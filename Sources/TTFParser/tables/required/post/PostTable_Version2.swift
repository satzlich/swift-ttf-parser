// Copyright 2024 Lie Yan

import Foundation

extension PostTable {
    public struct Version2: SafeDecodable {
        public let numGlyphs: UInt16
        public let glyphNameIndex: FlatArray<UInt16>
        public let stringData: UnsafeBufferPointer<UInt8>

        private enum _Offsets {
            static let numGlyphs = 0
            static let glyphNameIndex = numGlyphs + UInt16.encodingWidth
            static func stringData(_ numGlyphs: Int) -> Int {
                _Offsets.glyphNameIndex + numGlyphs * UInt16.encodingWidth
            }
        }

        private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
            numGlyphs = .decode(bytes.baseAddress! + _Offsets.numGlyphs)
            guard let glyphNameIndex
                = FlatArray<UInt16>(bytes.rebase(_Offsets.glyphNameIndex), Int(numGlyphs))
            else {
                return nil
            }
            self.glyphNameIndex = glyphNameIndex
            let stringData = bytes.rebase(_Offsets.stringData(Int(numGlyphs)))
            self.stringData = stringData
        }

        public func nameForGlyph(_ glyphId: UInt16) -> String? {
            guard glyphId < self.numGlyphs else {
                return nil
            }
            guard let index = self.glyphNameIndex.at(Int(glyphId)) else {
                return nil
            }

            if index < MacintoshNames.count {
                return TTFParser.MacintoshNames[Int(index)]
            }
            else {
                return stringAt(index - UInt16(MacintoshNames.count))
            }
        }

        private func stringAt(_ index: UInt16) -> String? {
            let baseAddress = stringData.baseAddress!

            func find(_ index: UInt16, _ offset: Int) -> Int {
                if index == 0 {
                    return offset
                }
                else {
                    let length = (baseAddress + offset).pointee
                    return find(index - 1, offset + Int(length) + 1)
                }
            }

            let offset = find(index, 0)
            guard offset < stringData.count else {
                return nil
            }

            let pointer = baseAddress + offset
            let length = pointer.pointee
            let buffer = UnsafeBufferPointer(start: pointer + 1,
                                             count: Int(length))

            return String(decoding: buffer, as: UTF8.self)
        }

        public static var minWidth: Int {
            _Offsets.glyphNameIndex
        }

        public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> PostTable.Version2? {
            Version2(bytes)
        }
    }
}
