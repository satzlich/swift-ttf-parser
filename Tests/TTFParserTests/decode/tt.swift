// Copyright 2024 satzlich

import Testing
@testable import TTFParser

@Test func testUInt24() {
    #expect(UInt24.encodingSize == 3)
    #expect(UInt24.decode([0x01, 0x02, 0x03, 0x04]).rawValue == 0x010203)
}

@Test func testOffset24() {
    #expect(Offset24.encodingSize == 3)
    #expect(Offset24.decode([0x01, 0x02, 0x03, 0x04]).rawValue() == 0x010203)
}
