// Copyright 2024 Lie Yan

import Foundation

// MARK: - MaxpTable

public enum MaxpTable: SafeDecodable {
    case version0_5(Version0_5)
    case version1_0(Version1_0)

    public var numGlyphs: UInt16 {
        switch self {
        case let .version0_5(version0_5):
            return version0_5.numGlyphs
        case let .version1_0(version1_0):
            return version1_0.numGlyphs
        }
    }

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        let version = Version16Dot16.decode(bytes.baseAddress! + Offsets.version)

        switch version {
        case Version16Dot16(0x0000_5000):
            guard let version0_5 = Version0_5.decode(bytes) else {
                return nil
            }
            self = .version0_5(version0_5)

        case Version16Dot16(0x0001_0000):
            guard let version1_0 = Version1_0.decode(bytes) else {
                return nil
            }
            self = .version1_0(version1_0)

        case _:
            return nil
        }
    }

    private enum Offsets {
        static let version = Version0_5.Offsets.version
    }

    public static var minWidth: Int {
        Swift.min(Version0_5.minWidth, Version1_0.minWidth)
    }

    public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MaxpTable? {
        MaxpTable(bytes)
    }

    // MARK: - Versions

    public struct Version0_5: SafeDecodable {
        public let version: Version16Dot16
        public let numGlyphs: UInt16

        enum Offsets {
            static let version = 0
            static let numGlyphs = version + Version16Dot16.encodingWidth
        }

        private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
            guard bytes.count >= Self.minWidth else {
                return nil
            }
            self.version = Version16Dot16.decode(bytes.baseAddress! + Offsets.version)
            self.numGlyphs = UInt16.decode(bytes.baseAddress! + Offsets.numGlyphs)
        }

        public static var minWidth: Int {
            Offsets.numGlyphs + UInt16.encodingWidth
        }

        public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MaxpTable.Version0_5? {
            Version0_5(bytes)
        }
    }

    public struct Version1_0: SafeDecodable {
        public var version: Version16Dot16 {
            .decode(bytes + Offsets.version)
        }

        public var numGlyphs: UInt16 {
            .decode(bytes + Offsets.numGlyphs)
        }

        public var maxPoints: UInt16 {
            .decode(bytes + Offsets.maxPoints)
        }

        public var maxContours: UInt16 {
            .decode(bytes + Offsets.maxContours)
        }

        public var maxCompositePoints: UInt16 {
            .decode(bytes + Offsets.maxCompositePoints)
        }

        public var maxCompositeContours: UInt16 {
            .decode(bytes + Offsets.maxCompositeContours)
        }

        public var maxZones: UInt16 {
            .decode(bytes + Offsets.maxZones)
        }

        public var maxTwilightPoints: UInt16 {
            .decode(bytes + Offsets.maxTwilightPoints)
        }

        public var maxStorage: UInt16 {
            .decode(bytes + Offsets.maxStorage)
        }

        public var maxFunctionDefs: UInt16 {
            .decode(bytes + Offsets.maxFunctionDefs)
        }

        public var maxInstructionDefs: UInt16 {
            .decode(bytes + Offsets.maxInstructionDefs)
        }

        public var maxStackElements: UInt16 {
            .decode(bytes + Offsets.maxStackElements)
        }

        public var maxSizeOfInstructions: UInt16 {
            .decode(bytes + Offsets.maxSizeOfInstructions)
        }

        public var maxComponentElements: UInt16 {
            .decode(bytes + Offsets.maxComponentElements)
        }

        public var maxComponentDepth: UInt16 {
            .decode(bytes + Offsets.maxComponentDepth)
        }

        private let bytes: UnsafePointer<UInt8>

        public init?(_ bytes: UnsafeBufferPointer<UInt8>) {
            guard bytes.count >= Self.minWidth else {
                return nil
            }

            self.bytes = bytes.baseAddress!
        }

        private enum Offsets {
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
            Offsets.maxComponentDepth + UInt16.encodingWidth
        }

        public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MaxpTable.Version1_0? {
            Version1_0(bytes)
        }
    }
}
