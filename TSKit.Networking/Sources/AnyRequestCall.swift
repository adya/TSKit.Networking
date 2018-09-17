/**
 `AnyRequestCall` is an object that represents a single configured call of network request.
 
 - Requires:    iOS 2.0+
 - Requires:    Swift 2+
 - Version:     3.0
 - Since:        09/17/2018
 - Author:      Arkadii Hlushchevskyi
 */
public protocol AnyRequestCall: class {
    
    /// An object containing request configuration.
    var request: AnyRequest { get }
    
    /// Cancels request call either by cancelling dispatching of the request if it was not dispatched yet or
    /// by suppressing any response that will be received for that request.
    func cancel()
}
