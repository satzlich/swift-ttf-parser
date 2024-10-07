// Copyright 2024 Lie Yan

public protocol SafeDecodable {
    static var minWidth: Int { get }

    static func decode(_ bytes: UnsafeBufferPointer<UInt8>) -> Self?
}
