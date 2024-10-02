// Copyright 2024 Lie Yan

protocol VariableDecodable {
    static var leastWidth: Int { get }

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> Self?
}
