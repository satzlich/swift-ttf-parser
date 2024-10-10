// Copyright 2024 Lie Yan

// MARK: - MathValueRecord

public struct MathValueRecord: FixedDecodable {
    /**
     The X or Y value in design units.
     */
    public let value: FWORD

    /**
     Offset to the device table, from the beginning of parent table.
     May be NULL.
     */
    public let deviceOffset: Offset16

    private enum _Offsets {
        static let value = 0
        static let deviceOffset = value + FWORD.encodingWidth
    }

    private init(_ bytes: UnsafePointer<UInt8>) {
        self.value = FWORD.decode(bytes + _Offsets.value)
        self.deviceOffset = Offset16.decode(bytes + _Offsets.deviceOffset)
    }

    public static let encodingWidth =
        _Offsets.deviceOffset + Offset16.encodingWidth

    public static func decode(_ bytes: UnsafePointer<UInt8>) -> MathValueRecord {
        MathValueRecord(bytes)
    }
}

// MARK: - MathValueRecord + LiftableRecord

extension MathValueRecord: LiftableRecord {
    typealias LiftResult = MathValue

    func lift(_ bytes: UnsafeBufferPointer<UInt8>) -> MathValue {
        let deviceTable: DeviceTable? = deviceOffset.lift(bytes)
        return MathValue(value, deviceTable)
    }
}
