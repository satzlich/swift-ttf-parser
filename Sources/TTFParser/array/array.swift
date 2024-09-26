// Copyright 2024 satzlich

import Foundation

struct FArray<Element: FixedDecodable> {
    let _base: UnsafeBufferPointer<UInt8>

    init(_ begin: UnsafeBufferPointer<UInt8>, _ offset: Int) {
        self._base = UnsafeBufferPointer(rebasing: begin[offset...])
    }

    subscript(index: Int) -> Element {
        let offset = index * Element.encodingSize
        let addr = UnsafeBufferPointer<UInt8>(rebasing: self._base[offset...])
        assert(addr.count >= Element.encodingSize)
        return Element.decode(addr.baseAddress!)
    }
}

struct OArray<Offset, Element>
    where Offset: OffsetProtocol & FixedDecodable,
    Element: GeneralDecodable
{
    let _base: UnsafeBufferPointer<UInt8>
    let _offsets: FArray<Offset>

    init(_ base: UnsafeBufferPointer<UInt8>, _ offsets: FArray<Offset>) {
        self._base = base
        self._offsets = offsets
    }

    subscript(index: Int) -> Element {
        let offset = Int(_offsets[index].rawValue)
        let addr = UnsafeBufferPointer<UInt8>(rebasing: self._base[offset...])
        assert(!addr.isEmpty)
        return Element.decode(addr.baseAddress!)
    }
}
