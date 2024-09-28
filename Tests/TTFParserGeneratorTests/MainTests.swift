// Copyright 2024 Lie Yan

import Foundation
@testable import TTFParserGenerator
import XCTest

final class MainTests: XCTestCase {
    func testMain() throws {
        print("=========================================")
        print("Testing main...")

        let input =
            """
            struct Foo {
                uint8 a;
                Array<FWORD> b;
            }

            struct Bar {
                Offset24 c;
                LONGDATETIME d;
            }
            """

        try Main.run(with: input)
    }
}
