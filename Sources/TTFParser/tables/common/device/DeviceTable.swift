// Copyright 2024 Lie Yan

// MARK: - DeviceTable

struct DeviceTable: SafeDecodable {
    public let startSize: UInt16
    public let endSize: UInt16
    public let deltaFormat: UInt16
    public let deltaValue: FlatArray<UInt16>

    private enum Offsets {
        static let startSize = 0
        static let endSize = startSize + UInt16.encodingWidth
        static let deltaFormat = endSize + UInt16.encodingWidth
        static let deltaValue = deltaFormat + UInt16.encodingWidth
    }

    init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.minWidth else {
            return nil
        }

        self.startSize = UInt16.decode(bytes.baseAddress! + Offsets.startSize)
        self.endSize = UInt16.decode(bytes.baseAddress! + Offsets.endSize)
        self.deltaFormat = UInt16.decode(bytes.baseAddress! + Offsets.deltaFormat)

        // detlaValue
        do {
            let bytes = bytes.rebase(Offsets.deltaValue)

            let n = endSize - startSize + 1
            let count = ((n << deltaFormat) + 15) >> 4

            guard let deltaValue = FlatArray<UInt16>(bytes, Int(count)) else {
                return nil
            }
            self.deltaValue = deltaValue
        }
    }

    public static let minWidth: Int = Offsets.deltaValue

    public static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> DeviceTable? {
        DeviceTable(bytes)
    }
}

extension DeviceTable {
    func getDelta(_ ppem: UInt16, /* _ */ scale: UInt16) -> Int32? {
        guard ppem != 0, ppem >= startSize, ppem <= endSize else {
            return nil
        }

        let deltas = CompressedArray(deltaValue, Int(deltaFormat))
        guard let delta = deltas.at(Int(ppem - startSize)) else {
            return nil
        }

        return Int32(exactly: Int64(delta) * Int64(scale) / Int64(ppem))
    }
}

// MARK: - CompressedArray

private struct CompressedArray {
    private let flatArray: FlatArray<UInt16>
    private let detlaFormat: Int

    init(_ flatArray: FlatArray<UInt16>, _ deltaFormat: Int) {
        precondition((1 ... 3) ~= deltaFormat)

        self.flatArray = flatArray
        self.detlaFormat = deltaFormat
    }

    public func at(_ index: Int) -> Int16? {
        let s = UInt16(index)
        let f = detlaFormat

        guard let bytes: UInt16 = flatArray.at(index >> (4 - f)) else {
            return nil
        }
        let bits: UInt16 = bytes >> (16 - (((s & ((1 << (4 - f)) - 1)) + 1) << f))
        let mask = UInt16(0xFFFF) >> (16 - (1 << f))

        var delta = Int16(bits & mask)
        if delta >= Int16((mask + 1) >> 1) {
            delta -= Int16(mask + 1)
        }

        return delta
    }
}
