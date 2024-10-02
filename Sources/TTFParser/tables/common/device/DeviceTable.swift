// Copyright 2024 Lie Yan

struct DeviceTable: VariableDecodable {
    // MARK: - Properties

    public let startSize: UInt16
    public let endSize: UInt16
    public let deltaFormat: UInt16
    public let deltaValue: FlatArray<UInt16>

    // MARK: - Offsets

    enum Offsets {
        static let startSize = 0
        static let endSize = startSize + UInt16.encodingWidth
        static let deltaFormat = endSize + UInt16.encodingWidth
        static let deltaValue = deltaFormat + UInt16.encodingWidth
    }

    init?(_ bytes: UnsafeBufferPointer<UInt8>) {
        guard bytes.count >= Self.leastWidth else {
            return nil
        }
        let baseAddress = bytes.baseAddress!

        self.startSize = UInt16.decode(baseAddress + Offsets.startSize)
        self.endSize = UInt16.decode(baseAddress + Offsets.endSize)
        self.deltaFormat = UInt16.decode(baseAddress + Offsets.deltaFormat)

        // detlaValue
        let n = endSize - startSize + 1
        let count = ((n << deltaFormat) + 15) >> 4

        let bytes = bytes.rebase(Offsets.deltaValue)
        guard let deltaValue = FlatArray<UInt16>(bytes, Int(count)) else {
            return nil
        }
        self.deltaValue = deltaValue
    }

    // MARK: - VariableDecodable

    static var leastWidth: Int = Offsets.deltaValue

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> DeviceTable? {
        DeviceTable(bytes)
    }
}
