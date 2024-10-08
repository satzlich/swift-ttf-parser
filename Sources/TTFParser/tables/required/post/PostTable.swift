// Copyright 2024 Lie Yan

import Foundation

// MARK: - PostTable

public struct PostTable: SafeDecodable {
    private let header: Header
    private let variant: Variant

    enum Variant {
        case version1(Version1)
        case version2(Version2)
        case version2_5(Version2_5)
        case version3(Version3)
    }

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= PostTable.minWidth else {
            return nil
        }

        header = Header.decode(bytes.baseAddress!)

        let remainingBytes = bytes.rebase(Header.encodingWidth)

        switch header.version {
        case Version16Dot16(0x0001_0000):
            guard let version1 = Version1.decode(remainingBytes) else {
                return nil
            }
            variant = .version1(version1)

        case Version16Dot16(0x0002_0000):
            guard let version2 = Version2.decode(remainingBytes) else {
                return nil
            }
            variant = .version2(version2)

        case Version16Dot16(0x0002_5000):
            guard let version2_5 = Version2_5.decode(remainingBytes) else {
                return nil
            }
            variant = .version2_5(version2_5)

        case Version16Dot16(0x0003_0000):
            guard let version3 = Version3.decode(remainingBytes) else {
                return nil
            }
            variant = .version3(version3)

        case _:
            return nil
        }
    }

    // MARK: -

    public func nameForGlyph(_ glyphId: UInt16) -> String? {
        switch variant {
        case let .version1(version1):
            return version1.nameForGlyph(glyphId)
        case let .version2(version2):
            return version2.nameForGlyph(glyphId)
        case let .version2_5(version2_5):
            return version2_5.nameForGlyph(glyphId)
        case let .version3(version3):
            return version3.nameForGlyph(glyphId)
        }
    }

    // MARK: - Header properties

    public var version: Version16Dot16 {
        header.version
    }

    public var italicAngle: Fixed {
        header.italicAngle
    }

    public var underlinePosition: FWORD {
        header.underlinePosition
    }

    public var underlineThickness: FWORD {
        header.underlineThickness
    }

    public var isFixedPitch: UInt32 {
        header.isFixedPitch
    }

    public var minMemType42: UInt32 {
        header.minMemType42
    }

    public var maxMemType42: UInt32 {
        header.maxMemType42
    }

    public var minMemType1: UInt32 {
        header.minMemType1
    }

    public var maxMemType1: UInt32 {
        header.maxMemType1
    }

    // MARK: -

    public static var minWidth: Int {
        Header.encodingWidth + Swift.min(Version1.minWidth,
                                         Version2.minWidth,
                                         Version2_5.minWidth,
                                         Version3.minWidth)
    }

    public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> PostTable? {
        PostTable(bytes)
    }
}

extension PostTable {
    struct Header: FixedDecodable {
        public var version: Version16Dot16 {
            .decode(bytes + Offsets.version)
        }

        public var italicAngle: Fixed {
            .decode(bytes + Offsets.italicAngle)
        }

        public var underlinePosition: FWORD {
            .decode(bytes + Offsets.underlinePosition)
        }

        public var underlineThickness: FWORD {
            .decode(bytes + Offsets.underlineThickness)
        }

        public var isFixedPitch: UInt32 {
            .decode(bytes + Offsets.isFixedPitch)
        }

        public var minMemType42: UInt32 {
            .decode(bytes + Offsets.minMemType42)
        }

        public var maxMemType42: UInt32 {
            .decode(bytes + Offsets.maxMemType42)
        }

        public var minMemType1: UInt32 {
            .decode(bytes + Offsets.minMemType1)
        }

        public var maxMemType1: UInt32 {
            .decode(bytes + Offsets.maxMemType1)
        }

        enum Offsets {
            static let version = 0
            static let italicAngle = version + Version16Dot16.encodingWidth
            static let underlinePosition = italicAngle + Fixed.encodingWidth
            static let underlineThickness = underlinePosition + FWORD.encodingWidth
            static let isFixedPitch = underlineThickness + FWORD.encodingWidth
            static let minMemType42 = isFixedPitch + UInt32.encodingWidth
            static let maxMemType42 = minMemType42 + UInt32.encodingWidth
            static let minMemType1 = maxMemType42 + UInt32.encodingWidth
            static let maxMemType1 = minMemType1 + UInt32.encodingWidth
        }

        private let bytes: UnsafePointer<UInt8>
        private init(_ bytes: UnsafePointer<UInt8>) {
            self.bytes = bytes
        }

        static var encodingWidth: Int {
            Offsets.maxMemType1 + UInt32.encodingWidth
        }

        static func decode(_ bytes: UnsafePointer<UInt8>) -> PostTable.Header {
            PostTable.Header(bytes)
        }
    }

    /**
     258 Macintosh names
     */
    public struct Version1: SafeDecodable {
        public static var minWidth: Int { 0 }

        public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> PostTable.Version1? {
            PostTable.Version1()
        }

        public func nameForGlyph(_ glyphId: UInt16) -> String? {
            guard glyphId >= 0 && glyphId < MacintoshNames.count else {
                return nil
            }
            return MacintoshNames[Int(glyphId)]
        }
    }

    /**
     Deprecated
     */
    public struct Version2_5: SafeDecodable {
        public static var minWidth: Int { UInt16.encodingWidth }
        public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> PostTable.Version2_5? {
            PostTable.Version2_5()
        }

        public func nameForGlyph(_ glyphId: UInt16) -> String? {
            nil
        }
    }

    /**
     This version specifies that no PostScript name information is provided for the
     glyphs in this font file.
     */
    public struct Version3: SafeDecodable {
        public static var minWidth: Int { 0 }
        public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> PostTable.Version3? {
            PostTable.Version3()
        }

        public func nameForGlyph(_ glyphId: UInt16) -> String? {
            nil
        }
    }
}
