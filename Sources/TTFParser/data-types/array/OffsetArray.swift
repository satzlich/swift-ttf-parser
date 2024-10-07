// Copyright 2024 Lie Yan

// MARK: - OffsetArray

/**
 Array of lifted offsets.
 */
struct OffsetArray<O: OffsetProtocol & FixedDecodable, Element: SafeDecodable> {
    private let offsets: FlatArray<O>
    private let bytes: UnsafeBufferPointer<UInt8>

    init(_ offsets: FlatArray<O>, _ bytes: UnsafeBufferPointer<UInt8>) {
        self.offsets = offsets
        self.bytes = bytes
    }

    subscript(index: Int) -> Element? {
        offsets[index]?.lift(self.bytes)
    }
}

typealias OffsetArray16<T: SafeDecodable> = OffsetArray<Offset16, T>
typealias OffsetArray32<T: SafeDecodable> = OffsetArray<Offset32, T>
