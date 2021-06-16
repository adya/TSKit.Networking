// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation

/// `AnyRequestCall` is an object that represents a single configured call of network request.
public protocol AnyRequestCall: AnyObject {

    /// An object containing request configuration.
    var request: AnyRequestable { get }

    /// Number of recovery attempts that were made for this call.
    var recoveryAttempts: Int { get }
    
    /// All statuses that are valid for this call.
    ///
    /// This set is a union of all statuses for which handlers were configured in this call and additionally all valid statuses listed in request.
    var validStatusCodes: Set<HTTPStatusCode> { get }
    
    /// The original request object that was created for this call.
    ///
    /// This property contains an underlying `URLRequest` object that was created when
    /// this call is queued for execution. Until then `originalRequest` returns `nil`.
    var originalRequest: URLRequest? { get }
    
    /// Cancels request call either by cancelling dispatching of the request if it was not dispatched yet or
    /// by suppressing any response that will be received for that request.
    func cancel()
}
