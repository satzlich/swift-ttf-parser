// Copyright 2024 Lie Yan

enum TTCHeader: SafeDecodable {
    case version1(Version1)
    case version2(Version2)

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        switch UInt16.decode(bytes.baseAddress! + _Offsets.majorVersion) {
        case 1:
            guard let version1 = Version1.decode(bytes) else {
                return nil
            }
            self = .version1(version1)

        case 2:
            guard let version2 = Version2.decode(bytes) else {
                return nil
            }
            self = .version2(version2)

        default:
            return nil
        }
    }

    private enum _Offsets {
        static let ttcTag = Version1._Offsets.ttcTag
        static let majorVersion = Version1._Offsets.majorVersion
        static let minorVersion = Version1._Offsets.minorVersion
    }

    public static var minWidth: Int {
        Swift.min(Version1.minWidth, Version2.minWidth)
    }

    public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> TTCHeader? {
        TTCHeader(bytes)
    }

    struct Version1: SafeDecodable {
        public let ttcTag: Tag
        public let majorVersion: UInt16
        public let minorVersion: UInt16
        public let numFonts: UInt32
        public let tableDirectoryOffsets: FlatArray<Offset32>

        enum _Offsets {
            static let ttcTag = 0
            static let majorVersion = ttcTag + Tag.encodingWidth
            static let minorVersion = majorVersion + UInt16.encodingWidth
            static let numFonts = minorVersion + UInt16.encodingWidth
            static let tableDirectoryOffsets = numFonts + UInt32.encodingWidth
        }

        private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
            guard bytes.count >= Self.minWidth else {
                return nil
            }

            self.ttcTag = Tag.decode(bytes.baseAddress! + _Offsets.ttcTag)
            self.majorVersion = UInt16.decode(bytes.baseAddress! + _Offsets.majorVersion)
            self.minorVersion = UInt16.decode(bytes.baseAddress! + _Offsets.minorVersion)

            guard ttcTag == #tag("ttcf"),
                  majorVersion == 1,
                  minorVersion == 0
            else {
                return nil
            }

            self.numFonts = UInt32.decode(bytes.baseAddress! + _Offsets.numFonts)

            do {
                let bytes = bytes.rebase(_Offsets.tableDirectoryOffsets)
                let count = Int(self.numFonts)
                guard let tableDirectoryOffsets = FlatArray<Offset32>(bytes, count) else {
                    return nil
                }
                self.tableDirectoryOffsets = tableDirectoryOffsets
            }
        }

        public static var minWidth: Int {
            _Offsets.tableDirectoryOffsets
        }

        public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> TTCHeader.Version1? {
            TTCHeader.Version1(bytes)
        }
    }

    struct Version2: SafeDecodable {
        public let ttcTag: Tag
        public let majorVersion: UInt16
        public let minorVersion: UInt16
        public let numFonts: UInt32
        public let tableDirectoryOffsets: FlatArray<Offset32>
        public let dsigTag: Tag
        public let dsigLength: UInt32
        public let dsigOffset: Offset32

        private enum _Offsets {
            static let ttcTag = 0
            static let majorVersion = ttcTag + Tag.encodingWidth
            static let minorVersion = majorVersion + UInt16.encodingWidth
            static let numFonts = minorVersion + UInt16.encodingWidth
            static let tableDirectoryOffsets = numFonts + UInt32.encodingWidth

            static func dsigTag(_ numFonts: UInt32) -> Int {
                tableDirectoryOffsets + Int(numFonts) * Offset32.encodingWidth
            }

            static func dsigLength(_ numFonts: UInt32) -> Int {
                dsigTag(numFonts) + Tag.encodingWidth
            }

            static func dsigOffset(_ numFonts: UInt32) -> Int {
                dsigLength(numFonts) + UInt32.encodingWidth
            }
        }

        private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
            guard bytes.count >= Self.minWidth else {
                return nil
            }

            self.ttcTag = Tag.decode(bytes.baseAddress! + _Offsets.ttcTag)
            self.majorVersion = UInt16.decode(bytes.baseAddress! + _Offsets.majorVersion)
            self.minorVersion = UInt16.decode(bytes.baseAddress! + _Offsets.minorVersion)
            guard ttcTag == #tag("ttcf"),
                  majorVersion == 2,
                  minorVersion == 0
            else {
                return nil
            }

            self.numFonts = UInt32.decode(bytes.baseAddress! + _Offsets.numFonts)

            do {
                let bytes = bytes.rebase(_Offsets.tableDirectoryOffsets)
                let count = Int(self.numFonts)
                guard let tableDirectoryOffsets = FlatArray<Offset32>(bytes, count) else {
                    return nil
                }
                self.tableDirectoryOffsets = tableDirectoryOffsets
            }

            self.dsigTag = Tag.decode(bytes.baseAddress! + _Offsets.dsigTag(numFonts))
            if dsigTag == Tag.nullValue {
                self.dsigLength = 0
                self.dsigOffset = Offset32(0)
            }
            else {
                guard dsigTag == #tag("DSIG") else {
                    return nil
                }
                self.dsigLength = UInt32.decode(bytes.baseAddress! + _Offsets.dsigLength(numFonts))
                self.dsigOffset = Offset32.decode(bytes.baseAddress! + _Offsets.dsigOffset(numFonts))
            }
        }

        public static var minWidth: Int {
            _Offsets.tableDirectoryOffsets + UInt32.encodingWidth * 3
        }

        public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> TTCHeader.Version2? {
            TTCHeader.Version2(bytes)
        }
    }
}
