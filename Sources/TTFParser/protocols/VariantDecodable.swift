// Copyright 2024 Lie Yan

protocol VariantDecodable {
    static var leastWidth: Int { get }
    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> Self?
}
