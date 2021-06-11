// - Since: 06/11/2021
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation
import TSKit_Core

open class DeferredRetryRecoverer: AnyNetworkServiceRecoverer {
    
    public let maximumRecoveryAttempts: UInt
    
    public var recoverableStatuses: Set<Int>? = nil
        
    private var recoveringCalls: [Int: [RecoveryCompletion]] = [:]
    
    
    public init(recoverableStatuses: Set<Int>? = nil,
                maximumRecoveryAttempts: UInt = 1) {
        self.maximumRecoveryAttempts = maximumRecoveryAttempts
        self.recoverableStatuses = recoverableStatuses
    }
    
    /// Determines whether recoverer can recover `given` with provided `HTTPURLResponse` and `URLError`.
    ///
    /// Attempt recovery when all criterias met:
    /// - Received HTTP status code in response
    /// - And this status code is not in a range of valid statuses for the call (e.g. it considered as error)
    /// - Request call still has recovery attempts
    /// - And this status code is configured as recoverable.
    /// - Returns: Decision for recovery.
    open func canRecover(call: AnyRequestCall, response: HTTPURLResponse?, error: URLError?, in service: AnyNetworkService) -> Bool {
        guard let status = response?.statusCode else { return false }
        
        let maxRecoveryAttempts = call.request.maximumRecoveryAttempts ?? maximumRecoveryAttempts
        let recoverableStatuses = call.request.recoverableStatuses ?? self.recoverableStatuses
        
        return call.recoveryAttempts < maxRecoveryAttempts &&
               !call.validStatuses.contains(status) &&
               recoverableStatuses?.contains(status) ?? true
    }
    
    public func recover(call: AnyRequestCall, response: HTTPURLResponse?, error: URLError?, in service: AnyNetworkService, _ completion: @escaping RecoveryCompletion) {
        guard let status = response?.statusCode else { return completion(false) }
        
        // Check if there is already pending recovery for given status.
        if recoveringCalls[status] != nil {
            // If there is, then store retry completion in current call and add it to pending queue.
            recoveringCalls[status]?.append(completion)
        } else {
            // If there is no recoveries pending for given status then attempt one.
            recoveringCalls[status] = [completion]
            
            recover { [weak self] isRecovered in
                self?.recoveringCalls[status]?.forEach { $0(isRecovered) }
                self?.recoveringCalls[status] = nil
            }
        }
    }
    
    open func recover(_ completion: @escaping RecoveryCompletion) {
        completion(true)
    }
}
