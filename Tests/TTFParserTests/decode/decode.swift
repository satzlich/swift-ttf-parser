// Copyright 2024 satzlich

import Testing
@testable import TTFParser

@Test func testUInt24() {
    #expect(UInt24.encoding_size == 3)
    #expect(UInt24.decode([0x01, 0x02, 0x03, 0x04]).rawValue == 0x010203)
}

@Test func testOffset24() {
    #expect(Offset24.encoding_size == 3)

    do {
        let offset = Offset24.decode([0x01, 0x02, 0x03, 0x04])
        #expect(offset.raw_value() == 0x010203)
        #expect(offset.is_null() == false)
    }

    do {
        let offset = Offset24.decode([0x00, 0x00, 0x00, 0x00])
        #expect(offset.raw_value() == 0x000000)
        #expect(offset.is_null() == true)
    }
}

@Test func testVersion16Dot16() {
    #expect(Version16Dot16.encoding_size == 4)
    let version = Version16Dot16.decode([0x00, 0x01, 0x10, 0x00])

    #expect(version.rawValue == 0x0001_1000)
    #expect(version.major == 1)
    #expect(version.minor == 0x1000)
}
