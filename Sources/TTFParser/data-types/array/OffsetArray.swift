// Copyright 2024 Lie Yan

// MARK: - OffsetArray

/**
 Array of lifted offsets.
 */
public struct OffsetArray<O: OffsetProtocol & FixedDecodable, Element: SafeDecodable> {
    private let offsets: FlatArray<O>
    private let bytes: UnsafeBufferPointer<UInt8>

    init(_ offsets: FlatArray<O>, _ bytes: UnsafeBufferPointer<UInt8>) {
        self.offsets = offsets
        self.bytes = bytes
    }

    public var count: Int {
        offsets.count
    }

    public func at(_ index: Int) -> Element? {
        offsets.at(index)?.lift(self.bytes)
    }
}

// MARK: - OffsetArray + ArrayProtocol

extension OffsetArray: ArrayProtocol {
}

public typealias OffsetArray16<T: SafeDecodable> = OffsetArray<Offset16, T>
public typealias OffsetArray32<T: SafeDecodable> = OffsetArray<Offset32, T>
