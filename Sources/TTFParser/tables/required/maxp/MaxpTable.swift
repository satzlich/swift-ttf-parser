// Copyright 2024 Lie Yan

import Foundation

// MARK: - MaxpTable

public enum MaxpTable: SafeDecodable {
    case version0_5(Version0_5)
    case version1(Version1)

    public var numGlyphs: UInt16 {
        switch self {
        case let .version0_5(version0_5):
            return version0_5.numGlyphs
        case let .version1(version1_0):
            return version1_0.numGlyphs
        }
    }

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        let version = Version16Dot16.decode(bytes.baseAddress! + _Offsets.version)

        switch version {
        case Version16Dot16(0x0000_5000):
            guard let version0_5 = Version0_5.decode(bytes) else {
                return nil
            }
            self = .version0_5(version0_5)

        case Version16Dot16(0x0001_0000):
            guard let version1_0 = Version1.decode(bytes) else {
                return nil
            }
            self = .version1(version1_0)

        case _:
            return nil
        }
    }

    private enum _Offsets {
        static let version = Version0_5._Offsets.version
    }

    public static var minWidth: Int {
        Swift.min(Version0_5.minWidth, Version1.minWidth)
    }

    public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MaxpTable? {
        MaxpTable(bytes)
    }

    // MARK: - Versions

    public struct Version0_5: SafeDecodable {
        public let version: Version16Dot16
        public let numGlyphs: UInt16

        enum _Offsets {
            static let version = 0
            static let numGlyphs = version + Version16Dot16.encodingWidth
        }

        private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
            guard bytes.count >= Self.minWidth else {
                return nil
            }
            self.version = Version16Dot16.decode(bytes.baseAddress! + _Offsets.version)
            self.numGlyphs = UInt16.decode(bytes.baseAddress! + _Offsets.numGlyphs)
        }

        public static var minWidth: Int {
            _Offsets.numGlyphs + UInt16.encodingWidth
        }

        public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MaxpTable.Version0_5? {
            Version0_5(bytes)
        }
    }

    public struct Version1: SafeDecodable {
        public var version: Version16Dot16 {
            .decode(bytes + _Offsets.version)
        }

        public var numGlyphs: UInt16 {
            .decode(bytes + _Offsets.numGlyphs)
        }

        public var maxPoints: UInt16 {
            .decode(bytes + _Offsets.maxPoints)
        }

        public var maxContours: UInt16 {
            .decode(bytes + _Offsets.maxContours)
        }

        public var maxCompositePoints: UInt16 {
            .decode(bytes + _Offsets.maxCompositePoints)
        }

        public var maxCompositeContours: UInt16 {
            .decode(bytes + _Offsets.maxCompositeContours)
        }

        public var maxZones: UInt16 {
            .decode(bytes + _Offsets.maxZones)
        }

        public var maxTwilightPoints: UInt16 {
            .decode(bytes + _Offsets.maxTwilightPoints)
        }

        public var maxStorage: UInt16 {
            .decode(bytes + _Offsets.maxStorage)
        }

        public var maxFunctionDefs: UInt16 {
            .decode(bytes + _Offsets.maxFunctionDefs)
        }

        public var maxInstructionDefs: UInt16 {
            .decode(bytes + _Offsets.maxInstructionDefs)
        }

        public var maxStackElements: UInt16 {
            .decode(bytes + _Offsets.maxStackElements)
        }

        public var maxSizeOfInstructions: UInt16 {
            .decode(bytes + _Offsets.maxSizeOfInstructions)
        }

        public var maxComponentElements: UInt16 {
            .decode(bytes + _Offsets.maxComponentElements)
        }

        public var maxComponentDepth: UInt16 {
            .decode(bytes + _Offsets.maxComponentDepth)
        }

        private let bytes: UnsafePointer<UInt8>

        public init?(_ bytes: UnsafeBufferPointer<UInt8>) {
            guard bytes.count >= Self.minWidth else {
                return nil
            }

            self.bytes = bytes.baseAddress!
        }

        private enum _Offsets {
            static let version = 0
            static let numGlyphs = version + Version16Dot16.encodingWidth
            static let maxPoints = numGlyphs + UInt16.encodingWidth
            static let maxContours = maxPoints + UInt16.encodingWidth
            static let maxCompositePoints = maxContours + UInt16.encodingWidth
            static let maxCompositeContours = maxCompositePoints + UInt16.encodingWidth
            static let maxZones = maxCompositeContours + UInt16.encodingWidth
            static let maxTwilightPoints = maxZones + UInt16.encodingWidth
            static let maxStorage = maxTwilightPoints + UInt16.encodingWidth
            static let maxFunctionDefs = maxStorage + UInt16.encodingWidth
            static let maxInstructionDefs = maxFunctionDefs + UInt16.encodingWidth
            static let maxStackElements = maxInstructionDefs + UInt16.encodingWidth
            static let maxSizeOfInstructions = maxStackElements + UInt16.encodingWidth
            static let maxComponentElements = maxSizeOfInstructions + UInt16.encodingWidth
            static let maxComponentDepth = maxComponentElements + UInt16.encodingWidth
        }

        public static var minWidth: Int {
            _Offsets.maxComponentDepth + UInt16.encodingWidth
        }

        public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MaxpTable.Version1? {
            Version1(bytes)
        }
    }
}
