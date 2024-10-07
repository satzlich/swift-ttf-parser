// Copyright 2024 Lie Yan

@testable import TTFParser
import Foundation
import XCTest

// MARK: - TableDirectoryTests

final class TableDirectoryTests: XCTestCase {
    func testTableDirectory() {
        guard let fileURL = Bundle.module.url(forResource: "demo",
                                              withExtension: "ttf",
                                              subdirectory: "fonts")
        else {
            XCTFail("File not found")
            return
        }

        do {
            let data = try Data(contentsOf: fileURL)

            let tableDirectory = data.withUnsafeBytes {
                let bytes = $0.bindMemory(to: UInt8.self)
                return TableDirectory.decode(bytes)
            }

            guard let tableDirectory = tableDirectory
            else {
                XCTFail("Table directory not found")
                return
            }

            XCTAssertEqual(tableDirectory.sfntVersion, 0x0001_0000)
            XCTAssertEqual(tableDirectory.numTables, 7)
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
}
