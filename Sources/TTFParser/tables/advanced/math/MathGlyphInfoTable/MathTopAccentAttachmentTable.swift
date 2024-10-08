// Copyright 2024 Lie Yan

// MARK: - MathTopAccentAttachmentTable

public struct MathTopAccentAttachmentTable: SafeDecodable {
    private let topAccentAttachments: FlatArray<MathValueRecord>
    private var topAccentCoverage: CoverageTable

    private enum _Offsets {
        static let topAccentCoverageOffset = 0
        static let topAccentAttachmentCount = topAccentCoverageOffset + Offset16.encodingWidth
        static let topAccentAttachments = topAccentAttachmentCount + UInt16.encodingWidth
    }

    private let bytes: UnsafeBufferPointer<UInt8>

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        let topAccentCoverageOffset = Offset16.decode(bytes.baseAddress! + _Offsets.topAccentCoverageOffset)

        let topAccentAttachmentCount = UInt16.decode(bytes.baseAddress! + _Offsets.topAccentAttachmentCount)
        guard topAccentAttachmentCount > 0 else {
            return nil
        }

        let recordsBytes = bytes.rebase(_Offsets.topAccentAttachments)
        guard let topAccentAttachments
            = FlatArray<MathValueRecord>(recordsBytes, Int(topAccentAttachmentCount))
        else {
            return nil
        }
        self.topAccentAttachments = topAccentAttachments

        guard let topAccentCoverage: CoverageTable = topAccentCoverageOffset.lift(bytes)
        else {
            return nil
        }
        self.topAccentCoverage = topAccentCoverage

        self.bytes = bytes
    }

    public static let minWidth: Int = _Offsets.topAccentAttachments

    public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> MathTopAccentAttachmentTable? {
        MathTopAccentAttachmentTable(bytes)
    }
}

extension MathTopAccentAttachmentTable {
    public func get(_ glyphId: UInt16) -> MathValueRecord? {
        guard let index = topAccentCoverage.get(glyphId) else {
            return nil
        }
        return topAccentAttachments.at(Int(index))
    }
}
