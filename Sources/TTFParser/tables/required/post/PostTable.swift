// Copyright 2024 Lie Yan

import Foundation

// MARK: - PostTable

public enum PostTable {
    case version1(Version1)
    case version2(Version2)
    case version2_5(Version2_5)
    case version3(Version3)

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
}

// MARK: - %t + PostTable.Version2_5

extension PostTable {
    /**
     Deprecated
     */
    public struct Version2_5 {
    }
}
