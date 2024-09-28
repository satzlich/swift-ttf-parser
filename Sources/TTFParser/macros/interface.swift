// Copyright 2024 Lie Yan

import Foundation

@freestanding(expression)
public macro asciiCode(_ character: Character) -> UInt8 =
    #externalMacro(module: "TTFParserMacros", type: "AsciiCode")

@freestanding(expression)
public macro fourCharCode(_ characters: String) -> UInt32 =
    #externalMacro(module: "TTFParserMacros", type: "FourCharCode")

@freestanding(expression)
public macro tag(_ characters: String) -> Tag =
    #externalMacro(module: "TTFParserMacros", type: "Tag")
