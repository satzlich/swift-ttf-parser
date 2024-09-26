#! /bin/bash

antlr -Dlanguage=Swift -message-format gnu -o ../Sources/TTFParserGenerator/antlr Spec.g4
