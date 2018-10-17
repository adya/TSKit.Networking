/**
 `AnyRequestCall` is an object that represents a single configured call of network request.
 
 - Version:     3.0
 - Since:       10/15/2018
 - Author:      Arkadii Hlushchevskyi
 */
public protocol AnyRequestCall: class {
    
    /// An object containing request configuration.
    var request: AnyRequestable { get }

    /// Cancels request call either by cancelling dispatching of the request if it was not dispatched yet or
    /// by suppressing any response that will be received for that request.
    func cancel()
}
