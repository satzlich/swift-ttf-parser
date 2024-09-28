// Copyright 2024 Lie Yan

@freestanding(expression)
public macro asciiCode(_ charLiteral: Character) -> UInt8 =
    #externalMacro(module: "TTFParserMacros", type: "AsciiCode")

@freestanding(expression)
public macro fourCharCode(_ stringLiteral: String) -> UInt32 =
    #externalMacro(module: "TTFParserMacros", type: "FourCharCode")

@freestanding(expression)
public macro tag(_ stringLiteral: String) -> Tag =
    #externalMacro(module: "TTFParserMacros", type: "Tag")
