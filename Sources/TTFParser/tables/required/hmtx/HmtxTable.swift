// Copyright 2024 Lie Yan

import Foundation

public struct HmtxTable {
    public let hMetrics: FlatArray<LongHorMetric>
    public let leftSideBearings: FlatArray<FWORD>

    init?(_ bytes: UnsafeBufferPointer<UInt8>,
          /* hhea */ _ numberOfHMetrics: Int,
          /* maxp */ _ numGlyphs: Int)
    {
        guard numberOfHMetrics >= 0, numGlyphs >= 0,
              bytes.count >= HmtxTable.requiredWidth(numberOfHMetrics, numGlyphs)
        else {
            return nil
        }

        guard let hMetrics = FlatArray<LongHorMetric>(bytes, numberOfHMetrics)
        else {
            return nil
        }

        let offset = Offsets.leftSideBearings(numberOfHMetrics, numGlyphs)
        guard let leftSideBearings = FlatArray<FWORD>(bytes.rebase(offset),
                                                      numGlyphs - numberOfHMetrics)
        else {
            return nil
        }

        self.hMetrics = hMetrics
        self.leftSideBearings = leftSideBearings
    }

    private enum Offsets {
        static let hMetrics = 0
        static func leftSideBearings(_ numberOfHMetrics: Int, _ numGlyphs: Int) -> Int {
            hMetrics + numberOfHMetrics * LongHorMetric.encodingWidth
        }
    }

    private static func requiredWidth(_ numberOfHMetrics: Int, _ numGlyphs: Int) -> Int {
        numberOfHMetrics * LongHorMetric.encodingWidth +
            (numGlyphs - numberOfHMetrics) * FWORD.encodingWidth
    }
}
