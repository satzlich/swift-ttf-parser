// Copyright 2024 Lie Yan

import Foundation

// MARK: - FlatArray

struct FlatArray<Element: FixedDecodable> {
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

    public subscript(index: Int) -> Element? {
        guard index >= 0, index < self.count else {
            return nil
        }
        return Element.decode(self.baseAddress + index * Element.encodingWidth)
    }
}

extension FlatArray {
    @usableFromInline
    func binarySearch(_ key: Element) -> (index: Int, value: Element)?
        where Element: Comparable
    {
        self.binarySearch(key) { key, elem in
            if key < elem {
                return .orderedAscending
            }
            else if key > elem {
                return .orderedDescending
            }
            else {
                return .orderedSame
            }
        }
    }

    @usableFromInline
    func binarySearch<K>(
        _ key: K,
        _ comp: (Element, K) -> ComparisonResult
    ) -> (index: Int, value: Element)? {
        var first = 0
        var count = self.count

        while count > 0 {
            let step = count / 2
            let elem = self[first + step]!

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
}
