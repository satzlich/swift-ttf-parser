// Copyright 2024 Lie Yan

struct DeviceTable: VariableDecodable {
    // MARK: - Properties

    public var startSize: UInt16
    public var endSize: UInt16
    public var deltaFormat: UInt16
    public var deltaValue: FlatArray<UInt16>

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
        let calc = Calculator(self.startSize, self.endSize, self.deltaFormat)
        let bytes = bytes.rebase(Offsets.deltaValue)
        guard let deltaValue = FlatArray<UInt16>(bytes, calc.count) else {
            return nil
        }
        self.deltaValue = deltaValue
    }

    // MARK: - VariableDecodable

    static var leastWidth: Int = Offsets.deltaValue

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> DeviceTable? {
        DeviceTable(bytes)
    }

    private struct Calculator {
        let startSize: UInt16
        let endSize: UInt16
        let detlaFormat: UInt16

        init(_ startSize: UInt16, _ endSize: UInt16, _ detlaFormat: UInt16) {
            self.startSize = startSize
            self.endSize = endSize
            self.detlaFormat = detlaFormat
        }

        var n: Int {
            Int(self.endSize - self.startSize + 1)
        }

        var count: Int {
            ((self.n << self.detlaFormat) + 15) / 16
        }
    }
}
