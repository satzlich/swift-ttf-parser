// Copyright 2024 Lie Yan

import CoreText
import Foundation
import TTFParser

enum FontUtils {
    static func loadFont(
        forResource name: String,
        withExtension ext: String?,
        subdirectory subpath: String?
    ) -> (font: Font, data: Data)? {
        guard let fileURL = Bundle.module.url(forResource: name,
                                              withExtension: ext,
                                              subdirectory: subpath)
        else {
            return nil
        }

        guard let data = try? Data(contentsOf: fileURL) else {
            return nil
        }

        let bytes = data.withUnsafeBytes { $0.bindMemory(to: UInt8.self) }

        guard let font = Font(bytes) else {
            return nil
        }

        return (font, data)
    }

    static func loadCTFont(
        forResource name: String,
        withExtension ext: String?,
        subdirectory subpath: String?
    ) -> CTFont? {
        guard let fileURL = Bundle.module.url(forResource: name,
                                              withExtension: ext,
                                              subdirectory: subpath)
        else {
            return nil
        }

        let fontDescriptor
            = CTFontManagerCreateFontDescriptorsFromURL(fileURL as CFURL) as! [CTFontDescriptor]
        let defaultSize = 10.0
        return CTFontCreateWithFontDescriptor(fontDescriptor[0], defaultSize, nil)
    }
}
