// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "swift-ttf-parser",
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
    ],

    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.0"),
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.1.2"),
        .package(url: "https://github.com/apple/swift-syntax", from: "510.0.0"),
    ],

    targets: [
        // TTFParser and tests
        .target(
            name: "TTFParser",
            dependencies: ["TTFParserMacros"]
        ),
        .testTarget(
            name: "TTFParserTests",
            dependencies: ["TTFParser"],
            resources: [
                .copy("fonts"),
            ]
        ),

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
    ]
)
