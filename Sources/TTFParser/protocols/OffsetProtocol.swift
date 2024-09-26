// Copyright 2024 Lie Yan

// MARK: - OffsetProtocol

public protocol OffsetProtocol {
    /**
     Nil if the offset is NULL; otherwise, the offset value.
     */
    var offsetValue: Int? { get }
}

extension OffsetProtocol {
    func lift<T: SafeDecodable>(_ bytes: UnsafeBufferPointer<UInt8>) -> T? {
        self.offsetValue.flatMap {
            T.decode(bytes.rebase($0))
        }
    }
}
