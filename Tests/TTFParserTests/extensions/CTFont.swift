// Copyright 2024 Lie Yan

import Foundation
import CoreText

extension CTFont {
    func getGlyphWithName(_ name: String) -> CGGlyph {
        let glyphName = name as CFString
        return CTFontGetGlyphWithName(self, glyphName)
    }
}
