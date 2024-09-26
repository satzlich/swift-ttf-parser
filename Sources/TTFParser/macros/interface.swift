// Copyright 2024 satzlich

import Foundation

@freestanding(expression)
public macro ascii_code(_ character: Character) -> UInt8 =
    #externalMacro(module: "TTFParserMacros", type: "AsciiCode")

@freestanding(expression)
public macro four_char_code(_ characters: String) -> UInt32 =
    #externalMacro(module: "TTFParserMacros", type: "FourCharCode")

@freestanding(expression)
macro tag(_ characters: String) -> Tag =
    #externalMacro(module: "TTFParserMacros", type: "Tag")
