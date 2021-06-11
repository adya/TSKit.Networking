// - Since: 06/11/2021
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation

/// A simple recoverer that
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
    public var retriableMethods: Set<RequestMethod>
    
    /// Number of attempts that request should be retried.
    ///
    /// Setting this value to `0` efffectively disables this recoverer.
    /// Defaults to 1.
    /// - Note: If set, `AnyRequestable.maximumRecoveryAttempts` take precedence over this property.
    public var retryAttempts: UInt
    
    /// Set of HTTP response statuses that should be retried.
    /// - Note: If set, `AnyRequestable.recoverableStatuses` take precedence over this property.
    ///
    /// Defaults to following set:
    /// - 408 = Request Timeout
    /// - 500 = Internal Server Error
    /// - 502 = Bad Gateway
    /// - 503 = Service Unavailable
    /// - 504 = Gateway Timeout
    public var retriableStatuses: Set<Int>?
    
    /// Set of errors that are considered to be recoverable with multiple retries.
    /// Defaults to `nil` which falls back to predefined values.
    /// - Note: If set, `AnyRequestable.recoverableFailures` take precedence over this property.
    public var retriableFailures: Set<URLError.Code>?
    
    public init(retriableMethods: Set<RequestMethod> = [.get, .head, .delete, .options, .put, .trace],
                retriableStatuses: Set<Int>? = nil,
                retryAttempts: UInt = 1,
                retriableFailures: Set<URLError.Code>? = nil) {
        self.retriableMethods = retriableMethods
        self.retriableStatuses = retriableStatuses
        self.retriableFailures = retriableFailures
        self.retryAttempts = retryAttempts
    }
    
    open func canRecover(call: AnyRequestCall,
                           response: HTTPURLResponse?,
                           error: URLError?,
                           in service: AnyNetworkService) -> Bool {
        let requestable = call.request
        let retriableMethods = self.retriableMethods
        let retriableFailures = requestable.recoverableFailures ?? self.retriableFailures
        let retriableStatuses = requestable.recoverableStatuses ?? self.retriableStatuses
                
        guard let maxRetries = requestable.maximumRecoveryAttempts?.nonZero ?? retryAttempts.nonZero else { return false }
        
        let canRetryMore = call.recoveryAttempts < maxRetries
        let isRetriableMethod = retriableMethods.contains(requestable.method)
        
        let isRetriableError = { error.flatMap { retriableFailures?.contains($0.code) } ?? true }
        let isRetriableStatus = { response.flatMap { retriableStatuses?.contains($0.statusCode) } ?? true }
        
        return isRetriableMethod && canRetryMore && (isRetriableStatus() || isRetriableError())
    }
    
    public func recover(call: AnyRequestCall,
                        response: HTTPURLResponse?,
                        error: URLError?,
                        in service: AnyNetworkService,
                        _ completion: @escaping RecoveryCompletion) {
        completion(true)
    }
}
