#! /bin/bash

antlr -Dlanguage=Swift -message-format gnu -o ../Sources/TTFParserGenerator/antlr Specification.g4
