// Copyright 2024 Lie Yan

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

    static let minWidth: Int = Offsets.deltaValue

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> DeviceTable? {
        DeviceTable(bytes)
    }
}
