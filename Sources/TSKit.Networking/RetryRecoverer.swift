// - Since: 06/11/2021
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation

/// A simple recoverer that attempts a number of retries for each request if it matches certain criteria based on HTTP response, status code and error.
///
/// You can subclass `RetryRecoverer` to provide custom conditions as to when it should recover requests as well as any additional actions to be performed during recovery.
/// - Note: `recover(call:response:error:in:_:)` as well as `update(request:afterRecovering:in:)` do nothing. You should subclass and override these methods to provide custom logic.
open class RetryRecoverer: AnyNetworkServiceRecoverer {
    
    /// HTTP Methods that should be retried.
    ///
    /// Defaults to all idempotent methods:
    /// - GET
    /// - HEAD
    /// - DELETE
    /// - OPTIONS
    /// - PUT
    /// - TRACE
    public var recoverableMethods: Set<RequestMethod>
    
    /// Number of attempts that request should be attempted to recover.
    ///
    /// Setting this value to `0` efffectively disables this recoverer.
    /// Defaults to 1.
    /// - Note: If set, `AnyRequestable.maximumRecoveryAttempts` take precedence over this property.
    public var maximumRecoveryAttempts: UInt
    
    /// Set of HTTP response statuses that should be retried.
    /// - Note: If set, `AnyRequestable.recoverableStatuses` take precedence over this property.
    ///
    /// Defaults to the following set:
    /// - 408 Request Timeout
    /// - 500 Internal Server Error
    /// - 502 Bad Gateway
    /// - 503 Service Unavailable
    /// - 504 Gateway Timeout
    public var recoverableStatuses: Set<HTTPStatusCode>?
    
    /// Set of errors that are considered to be recoverable with multiple retries.
    ///
    /// Defaults to `nil`.
    /// - Note: If set, `AnyRequestable.recoverableFailures` take precedence over this property.
    public var recoverableFailures: Set<URLError.Code>?
    
    public init(recoverableMethods: Set<RequestMethod> = .allIdempotent,
                recoverableStatuses: Set<HTTPStatusCode>? = [408, 500, 502, 503, 504],
                maximumRecoveryAttempts: UInt = 1,
                recoverableFailures: Set<URLError.Code>? = nil) {
        self.recoverableMethods = recoverableMethods
        self.recoverableStatuses = recoverableStatuses
        self.recoverableFailures = recoverableFailures
        self.maximumRecoveryAttempts = maximumRecoveryAttempts
    }
    
    /// Determines whether recoverer can recover given `call` that encountered an error with provided `HTTPURLResponse` and `URLError`.
    ///
    /// This method is getting called for every `AnyRequestCall` that fails for any reason to determine
    /// if it can be recovered and retried afterwards.
    ///
    /// Following conditions have to be met in order to retry the call:
    /// - Request's method is contained in `recoverableMethods`.
    /// - Received HTTP status code is contained in `recoverableStatuses` (if not nil).
    /// - Provided `error` is contained in `recoverableFailures` (if not nil).
    /// - Request call has not exceeded number of recovery attempts.
    ///
    /// - Parameter call: A request call that encountered an error.
    /// - Parameter response: An `HTTPURLResponse` received along with error.
    /// - Parameter error: An `URLError` describing occurred error.
    /// - Parameter service: An instance of `AnyNetworkService` that is processing the call.
    /// - Returns: Decision for recovery.
    open func canRecover(call: AnyRequestCall,
                           response: HTTPURLResponse?,
                           error: URLError?,
                           in service: AnyNetworkService) -> Bool {
        let requestable = call.request
        let recoverableMethods = self.recoverableMethods
        let recoverableFailures = requestable.recoverableFailures ?? self.recoverableFailures
        let recoverableStatuses = requestable.recoverableStatuses ?? self.recoverableStatuses
        let maximumRecoveryAttempts = requestable.maximumRecoveryAttempts ?? self.maximumRecoveryAttempts
        
        let canRecoverMore = call.recoveryAttempts < maximumRecoveryAttempts
        let isRecoverableMethod = recoverableMethods.contains(requestable.method)
        
        let isRecoverableError = { error.flatMap { recoverableFailures?.contains($0.code) } ?? false }
        let isRecoverableStatus = { response.flatMap { recoverableStatuses?.contains($0.statusCode) } ?? false }
        
        return isRecoverableMethod && canRecoverMore && (isRecoverableStatus() || isRecoverableError())
    }
    
    open func recover(call: AnyRequestCall,
                        response: HTTPURLResponse?,
                        error: URLError?,
                        in service: AnyNetworkService,
                        _ completion: @escaping RecoveryCompletion) {
        completion(true)
    }
    
    open func update(request: inout URLRequest, afterRecovering call: AnyRequestCall, in service: AnyNetworkService) {}
}
