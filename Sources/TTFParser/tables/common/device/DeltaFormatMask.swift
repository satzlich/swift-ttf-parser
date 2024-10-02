// Copyright 2024 Lie Yan

/**
 Masks for DeltaFormat value.
 */
enum DeltaFormatMask {
    public static let LOCAL_2_BIT_DELTAS: UInt16 = 0x0001
    public static let LOCAL_4_BIT_DELTAS: UInt16 = 0x0002
    public static let LOCAL_8_BIT_DELTAS: UInt16 = 0x0003
    public static let VARIATION_INDEX: UInt16 = 0x8000
    public static let Reserved: UInt16 = 0x7FFC
}
