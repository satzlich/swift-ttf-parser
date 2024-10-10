// Copyright 2024 Lie Yan

public enum CoverageTable: SafeDecodable {
    case format1(Format1)
    case format2(Format2)

    private enum _Offsets {
        static let format = Format1._Offsets.format
    }

    private init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        let format = UInt16.decode(bytes.baseAddress! + _Offsets.format)

        switch format {
        case 1:
            guard let format1 = Format1.decode(bytes) else {
                return nil
            }
            self = .format1(format1)

        case 2:
            guard let format2 = Format2.decode(bytes) else {
                return nil
            }
            self = .format2(format2)

        case _:
            return nil
        }
    }

    public static var minWidth: Int {
        Swift.min(Format1.minWidth, Format2.minWidth)
    }

    public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> CoverageTable? {
        CoverageTable(bytes)
    }

    public func get(_ glyphId: UInt16) -> UInt16? {
        switch self {
        case let .format1(format1):
            return format1.get(glyphId)
        case let .format2(format2):
            return format2.get(glyphId)
        }
    }

    public func contains(_ glyphId: UInt16) -> Bool {
        switch self {
        case let .format1(format1):
            return format1.contains(glyphId)
        case let .format2(format2):
            return format2.contains(glyphId)
        }
    }
}
