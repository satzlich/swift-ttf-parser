// Copyright 2024 Lie Yan

struct FlatArray<T: FixedDecodable> {
    public let count: Int
    public let baseAddress: UnsafePointer<UInt8>

    init?(_ bytes: UnsafeBufferPointer<UInt8>, _ count: Int) {
        guard bytes.count >= T.encodingWidth * count
        else {
            return nil
        }

        self.count = count
        self.baseAddress = bytes.baseAddress!
    }

    public subscript(index: Int) -> T? {
        guard index >= 0, index < self.count else {
            return nil
        }
        return T.decode(self.baseAddress + index * T.encodingWidth)
    }
}
