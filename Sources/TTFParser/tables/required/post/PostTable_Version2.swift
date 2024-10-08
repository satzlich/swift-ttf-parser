// Copyright 2024 Lie Yan

import Foundation

extension PostTable {
    public struct Version2: SafeDecodable {
        public let numGlyphs: UInt16
        public let glyphNameIndex: FlatArray<UInt16>
        public let stringData: UnsafeBufferPointer<UInt8>

        private enum Offsets {
            static let numGlyphs = 0
            static let glyphNameIndex = numGlyphs + UInt16.encodingWidth
            static func stringData(_ numGlyphs: Int) -> Int {
                Offsets.glyphNameIndex + numGlyphs * UInt16.encodingWidth
            }
        }

        private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
            numGlyphs = .decode(bytes.baseAddress! + Offsets.numGlyphs)
            guard let glyphNameIndex
                = FlatArray<UInt16>(bytes.rebase(Offsets.glyphNameIndex), Int(numGlyphs))
            else {
                return nil
            }
            self.glyphNameIndex = glyphNameIndex
            let stringData = bytes.rebase(Offsets.stringData(Int(numGlyphs)))
            self.stringData = stringData
        }

        public func nameForGlyph(_ glyphId: UInt16) -> String? {
            guard glyphId < self.numGlyphs else {
                return nil
            }
            guard let index = self.glyphNameIndex.at(Int(glyphId)) else {
                return nil
            }

            if index < 258 {
                return TTFParser.macintoshNames[Int(index)]
            }
            else {
                return stringAt(Int(index - 258))
            }
        }

        private func stringAt(_ index: Int) -> String? {
            let baseAddress = stringData.baseAddress!

            func find(_ index: Int, _ offset: Int) -> Int {
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
            Offsets.glyphNameIndex
        }

        public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> PostTable.Version2? {
            Version2(bytes)
        }
    }
}
