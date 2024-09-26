// Copyright 2024 satzlich

import Testing
@testable import TTFParser

@Test func testUInt24() {
    #expect(UInt24.encoding_size == 3)
    #expect(UInt24.decode([0x01, 0x02, 0x03, 0x04]).rawValue == 0x010203)
}

@Test func testF2DOT14() {
    #expect(F2DOT14.encoding_size == 2)

    let eps: Float = 0.5 / 16384

    func approxEqual<T: FloatingPoint>(_ a: T, _ b: T, _ eps: T) -> Bool {
        abs(a - b) < eps
    }

    // 0x7fff -> 1.999939
    do {
        let f = F2DOT14.decode([0x7F, 0xFF])
        #expect(f.asFloat() == 1.999939)
    }

    // 0x7000 -> 1.75
    do {
        let f = F2DOT14.decode([0x70, 0x00])
        #expect(f.asFloat() == 1.75)
    }

    // 0x0001 -> 0.000061
    do {
        let f = F2DOT14.decode([0x00, 0x01])
        #expect(approxEqual(f.asFloat(), 0.000061, eps))
    }

    // 0x0000 -> 0.0
    do {
        let f = F2DOT14.decode([0x00, 0x00])
        #expect(f.asFloat() == 0.0)
    }

    // 0xffff -> -0.000061
    do {
        let f = F2DOT14.decode([0xFF, 0xFF])
        #expect(approxEqual(f.asFloat(), -0.000061, eps))
    }

    // 0x8000 -> -2.0
    do {
        let f = F2DOT14.decode([0x80, 0x00])
        #expect(f.asFloat() == -2.0)
    }
}

@Test func testOffset24() {
    #expect(Offset24.encoding_size == 3)

    do {
        let offset = Offset24.decode([0x01, 0x02, 0x03, 0x04])
        #expect(offset.rawValue == 0x010203)
        #expect(offset.isNull == false)
    }

    do {
        let offset = Offset24.decode([0x00, 0x00, 0x00, 0x00])
        #expect(offset.rawValue == 0x000000)
        #expect(offset.isNull == true)
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
