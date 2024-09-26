// Copyright 2024 Lie Yan

extension UnsafeBufferPointer {
    func rebase(_ offset: Int) -> Self {
        UnsafeBufferPointer<Self.Element>(rebasing: self[offset...])
    }
}
