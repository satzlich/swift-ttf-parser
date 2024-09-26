// Copyright 2024 Lie Yan

@testable import TTFParser
import XCTest

final class DataTypeTests: XCTestCase {
    // MARK: - F2DOT14

    func testF2DOT14() {
        let eps: Float = 0.001 / 16384

        // 0x7fff -> 1.999939
        do {
            let value = F2DOT14.decode([0x7F, 0xFF])
            XCTAssertEqual(value.floatValue, 1.999939)
        }

        // 0x7000 -> 1.75
        do {
            let value = F2DOT14.decode([0x70, 0x00])
            XCTAssertEqual(value.floatValue, 1.75)
        }

        // 0x0001 -> 0.000061
        do {
            let value = F2DOT14.decode([0x00, 0x01])
            XCTAssertEqual(value.floatValue, 0.000061, accuracy: eps)
        }

        // 0x0000 -> 0.0
        do {
            let value = F2DOT14.decode([0x00, 0x00])
            XCTAssertEqual(value.floatValue, 0.0)
        }

        // 0xffff -> -0.000061
        do {
            let value = F2DOT14.decode([0xFF, 0xFF])
            XCTAssertEqual(value.floatValue, -0.000061, accuracy: eps)
        }

        // 0x8000 -> -2.0
        do {
            let value = F2DOT14.decode([0x80, 0x00])
            XCTAssertEqual(value.floatValue, -2.0)
        }
    }

    // MARK: - Offset16

    func testOffset16() {
        XCTAssertEqual(Offset16.encodingWidth, 2)

        do {
            let offset = Offset16.decode([0x00, 0x00, 0x00, 0x00])
            XCTAssertEqual(offset.offsetValue, nil)
        }

        do {
            let offset = Offset16.decode([0x01, 0x02, 0x03, 0x04])
            XCTAssertEqual(offset.offsetValue, 0x0102)
        }
    }

    // MARK: - Offset24

    func testOffset24() {
        XCTAssertEqual(Offset24.encodingWidth, 3)

        // null
        do {
            let offset = Offset24.decode([0x00, 0x00, 0x00, 0x00])
            XCTAssertEqual(offset.offsetValue, nil)
        }

        // not null
        do {
            let offset = Offset24.decode([0x01, 0x02, 0x03, 0x04])
            XCTAssertEqual(offset.offsetValue, 0x010203)
        }
    }

    // MARK: - Version16Dot16

    func testVersion16Dot16() {
        let version = Version16Dot16.decode([0x01, 0x02, 0x03, 0x04])
        XCTAssertEqual(version, Version16Dot16(0x0102_0304))
    }

    // MARK: - UInt24

    func testUInt24() {
        XCTAssertEqual(UInt24.encodingWidth, 3)

        do {
            let value = UInt24.decode([0x01, 0x02, 0x03, 0x04])
            XCTAssertEqual(value.intValue, 0x010203)
        }
    }
}
