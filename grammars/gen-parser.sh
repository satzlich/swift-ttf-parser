#! /bin/bash

antlr \
    -no-listener -visitor \
    -Dlanguage=Swift -message-format gnu \
    -o ../Sources/TTFParserGenerator/antlr-gen Specification.g4
