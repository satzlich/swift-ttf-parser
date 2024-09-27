// Copyright 2024 satzlich

import Foundation

struct FArray<Element: FixedDecodable> {
    let _base: UnsafeBufferPointer<UInt8>

    init(_ begin: UnsafeBufferPointer<UInt8>, _ offset: Int) {
        self._base = UnsafeBufferPointer(rebasing: begin[offset...])
    }

    subscript(index: Int) -> Element {
        let offset = index * Element.encodingWidth
        let addr = UnsafeBufferPointer<UInt8>(rebasing: self._base[offset...])
        assert(addr.count >= Element.encodingWidth)
        return Element.decode(addr.baseAddress!)
    }
}
