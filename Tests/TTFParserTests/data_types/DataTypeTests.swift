// Copyright 2024 satzlich

@testable import TTFParser

import XCTest

final class DataTypeTests: XCTestCase {
    func testUInt24() {
        XCTAssertEqual(UInt24.encodingWidth, 3)
        XCTAssertEqual(UInt24.decode([0x01, 0x02, 0x03, 0x04]).rawValue, 0x010203)
    }

    func testF2DOT14() {
        let eps: Float = 0.5 / 16384

        func approxEqual<T: FloatingPoint>(_ a: T, _ b: T, _ eps: T) -> Bool {
            abs(a - b) < eps
        }

        // 0x7fff -> 1.999939
        do {
            let f = F2DOT14.decode([0x7F, 0xFF])
            XCTAssertEqual(f.floatValue, 1.999939)
        }

        // 0x7000 -> 1.75
        do {
            let f = F2DOT14.decode([0x70, 0x00])
            XCTAssertEqual(f.floatValue, 1.75)
        }

        // 0x0001 -> 0.000061
        do {
            let f = F2DOT14.decode([0x00, 0x01])
            XCTAssert(approxEqual(f.floatValue, 0.000061, eps))
        }

        // 0x0000 -> 0.0
        do {
            let f = F2DOT14.decode([0x00, 0x00])
            XCTAssertEqual(f.floatValue, 0.0)
        }

        // 0xffff -> -0.000061
        do {
            let f = F2DOT14.decode([0xFF, 0xFF])
            XCTAssert(approxEqual(f.floatValue, -0.000061, eps))
        }

        // 0x8000 -> -2.0
        do {
            let f = F2DOT14.decode([0x80, 0x00])
            XCTAssertEqual(f.floatValue, -2.0)
        }
    }

    func testOffset24() {
        XCTAssertEqual(Offset24.encodingWidth, 3)

        do {
            let offset = Offset24.decode([0x01, 0x02, 0x03, 0x04])
            XCTAssertEqual(offset.rawValue, 0x010203)
            XCTAssertEqual(offset.isNull, false)
        }

        do {
            let offset = Offset24.decode([0x00, 0x00, 0x00, 0x00])
            XCTAssertEqual(offset.rawValue, 0x000000)
            XCTAssertEqual(offset.isNull, true)
        }
    }

    func testVersion16Dot16() {
        XCTAssertEqual(Version16Dot16.decode([0x01, 0x02, 0x03, 0x04]).rawValue, 0x0102_0304)
    }
}
