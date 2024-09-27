// Copyright 2024 satzlich

import Antlr4
import Foundation

func main() throws {
    let input =
        """
        struct MathValueRecord {
            FWORD value;

            // @Field(DeviceTable deviceTable, parent)
            Offset16 deviceOffset;
        }
        """

    let lexer = SpecificationLexer(ANTLRInputStream(input))
    let parser = try SpecificationParser(CommonTokenStream(lexer))
    let context = try parser.specification()

    // get our representation
    let translator = TranslationVisitor()
    guard let node = context.accept(translator),
          let specification = node as? SpecificationNode
    else {
        print("Failed to translate input.")
        return
    }
    
    print(specification)
}

do {
    try main()
}
catch {
    print(error)
}
