// Copyright 2024 satzlich

import Antlr4
import Foundation

func run() throws {
    let input =
        """
        struct Foo {
            uint8 a;
            Array<FWORD> b;
        }
        """
    try run(with: input)
}

func run(with input: String) throws {
    let lexer = SpecificationLexer(ANTLRInputStream(input))
    let parser = try SpecificationParser(CommonTokenStream(lexer))
    let context = try parser.specification()

    // translate to our representation
    guard let specification = translate(context)
    else {
        print("Failed to translate input.")
        return
    }

    print(specification)
}

// main entry point

do {
    try run()
}
catch {
    print(error)
}
