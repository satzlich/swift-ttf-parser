# swift-ttf-parser

A high-level, zero-allocation font parser for TrueType and OpenType.

## Status

This library isn't intended to be complete by any stretch. Here is the supported tables.

### Required tables

* head
* hhea
* hmtx
* maxp
* post

### Advanced typographic tables

* MATH (constants, glyph info, and variants)
    * Hinting with device table is omitted.

## License

Apache 2.0

## See also

The design of this library is inspired by 
- [ttf-parser](https://github.com/RazrFalcon/ttf-parser/tree/master) (Rust), and 
- [OpenTypeSwift](https://github.com/mossprescott/OpenTypeSwift).

Unit tests for math table are mostly adapted from
 [harfbuzz](https://github.com/harfbuzz/harfbuzz).

The ultimate reference is [OpenType specification](https://learn.microsoft.com/en-us/typography/opentype/spec/).
