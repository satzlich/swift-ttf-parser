// Copyright 2024 Lie Yan

struct MathValueRecord: FixedDecodable {
    /**
     The X or Y value in design units.
     */
    public let value: FWORD

    /**
     Offset to the device table, from the beginning of parent table.
     May be NULL.
     */
    public let deviceOffset: Offset16

    private enum Offsets {
        static let value = 0
        static let deviceOffset = value + FWORD.encodingWidth
    }

    private init(_ bytes: UnsafePointer<UInt8>) {
        self.value = FWORD.decode(bytes + Offsets.value)
        self.deviceOffset = Offset16.decode(bytes + Offsets.deviceOffset)
    }

    static let encodingWidth =
        Offsets.deviceOffset + Offset16.encodingWidth

    static func decode(_ bytes: UnsafePointer<UInt8>) -> MathValueRecord {
        MathValueRecord(bytes)
    }
}
