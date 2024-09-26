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

    /// Examples: The version field of 'maxp' table version 0.5 is 0x00005000, and
    /// that of 'vhea' table version 1.1 is 0x00011000.

    // version 0.5
    do {
        let version = Version16Dot16.decode([0x00, 0x00, 0x50, 0x00])

        #expect(version.rawValue == 0x0000_5000)
        #expect(version.major == 0)
        #expect(version.minor == 5)
    }

    // version 1.0
    do {
        let version = Version16Dot16.decode([0x00, 0x01, 0x00, 0x00])

        #expect(version.rawValue == 0x0001_0000)
        #expect(version.major == 1)
        #expect(version.minor == 0)
    }

    // version 1.2
    do {
        let version = Version16Dot16.decode([0x00, 0x01, 0x20, 0x00])

        #expect(version.rawValue == 0x0001_2000)
        #expect(version.major == 1)
        #expect(version.minor == 2)
    }
}
