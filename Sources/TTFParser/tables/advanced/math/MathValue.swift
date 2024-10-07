// Copyright 2024 Lie Yan

import Foundation

struct MathValue {
    public let value: FWORD
    public let deviceTable: DeviceTable?

    init(_ value: FWORD, _ deviceTable: DeviceTable?) {
        self.value = value
        self.deviceTable = deviceTable
    }
}
