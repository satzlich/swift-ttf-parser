// Copyright 2024 satzlich

import Foundation
@testable import TTFParserGenerator
import XCTest

final class MainTests: XCTestCase {
    func testMain() throws {
        print("=========================================")
        print("Testing main...")

        try TTFParserGenerator.main()
    }
}
