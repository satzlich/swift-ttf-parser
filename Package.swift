// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "TTFParser",
    platforms: [
        .macOS(.v14),
        .iOS(.v12),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TTFParser",
            targets: ["TTFParser"]
        ),
        .library(
            name: "TTFParserGenerator",
            targets: ["TTFParserGenerator"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax", from: "510.0.0"),
    ],
    targets: [
        // TTFParserMacros and tests
        .macro(
            name: "TTFParserMacros",
            dependencies: [
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftDiagnostics", package: "swift-syntax"),
            ]
        ),
        .testTarget(
            name: "TTFParserMacrosTests",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
                "TTFParserMacros",
            ]
        ),

        // TTFParser and tests
        .target(
            name: "TTFParser",
            dependencies: ["TTFParserMacros"]
        ),
        .testTarget(
            name: "TTFParserTests",
            dependencies: ["TTFParser"]
        ),

        // TTFParserGenerator and tests
        .target(
            name: "TTFParserGenerator",
            dependencies: ["TTFParserMacros"]
        ),
        .testTarget(
            name: "TTFParserGeneratorTests",
            dependencies: ["TTFParserGenerator"]
        ),
    ]
)
