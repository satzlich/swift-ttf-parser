// Copyright 2024 Lie Yan

import Foundation

// MARK: - FlatArray

public struct FlatArray<Element: FixedDecodable> {
    @usableFromInline
    typealias Index = Int

    public let count: Int
    public let baseAddress: UnsafePointer<UInt8>

    @usableFromInline
    init?(_ bytes: UnsafeBufferPointer<UInt8>, _ count: Int) {
        guard bytes.count >= Element.encodingWidth * count
        else {
            return nil
        }

        self.count = count
        self.baseAddress = bytes.baseAddress!
    }

    public func at(_ index: Int) -> Element? {
        guard index >= 0, index < self.count else {
            return nil
        }
        return Element.decode(self.baseAddress + index * Element.encodingWidth)
    }
}

extension FlatArray {
    @usableFromInline
    typealias SearchResult = (index: Index, value: Element)

    @usableFromInline
    func binarySearch(_ key: Element) -> SearchResult?
        where Element: Comparable
    {
        self.binarySearch(key) { $0.compare($1) }
    }

    @usableFromInline
    func binarySearch<K>(
        _ key: K,
        _ comp: (Element, K) -> ComparisonResult
    ) -> SearchResult? {
        var first = 0
        var count = self.count

        while count > 0 {
            let step = count / 2
            let elem = self.at(first + step)!

            switch comp(elem, key) {
            case .orderedAscending:
                first += step + 1
                count -= step + 1
            case .orderedSame:
                return (first + step, elem)
            case .orderedDescending:
                count = step
            }
        }

        return nil
    }

    func upperBound(_ key: Element) -> Index where Element: Comparable {
        return self.upperBound(key) { $0 < $1 }
    }

    func upperBound<K>(_ key: K, _ comp: (K, Element) -> Bool) -> Index {
        var count = self.count
        var first: Index = 0

        while count > 0 {
            let step = count / 2
            let elem = self.at(first + step)!

            if !comp(key, elem) {
                first += step + 1
                count -= step + 1
            }
            else {
                count = step
            }
        }
        return first
    }
}

extension FlatArray where Element: Identifiable, Element.ID: Comparable {
    func get(_ id: Element.ID) -> Element? {
        binarySearch(id) { $0.id.compare($1) }?.value
    }
}

extension FlatArray where Element: OffsetProtocol {
    func offsetArray<T>(_ bytes: UnsafeBufferPointer<UInt8>) -> OffsetArray<Element, T>
    where T: SafeDecodable {
        OffsetArray<Element, T>(self, bytes)
    }
}

extension FlatArray where Element: LiftableRecord {
    func recordArray(_ bytes: UnsafeBufferPointer<UInt8>) -> RecordArray<Element> {
        RecordArray(self, bytes)
    }
}

// MARK: - FlatArray + Sequence

extension FlatArray: Sequence {
    public func makeIterator() -> AnyIterator<Element> {
        var index = 0
        return AnyIterator {
            guard index < self.count else {
                return nil
            }
            defer {
                index += 1
            }
            return self.at(index)
        }
    }
}

// MARK: - FlatArray + ArrayProtocol

extension FlatArray: ArrayProtocol {
}
