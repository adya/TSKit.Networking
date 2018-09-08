/// An opaque object used to cancel started routine.
public protocol AnyCancellationToken: class {
    
    /// Cancels routine associated with token.
    func cancel()
}
