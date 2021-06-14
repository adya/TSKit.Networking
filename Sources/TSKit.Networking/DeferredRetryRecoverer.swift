// - Since: 06/11/2021
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation
import TSKit_Core

/// A variation of `RetryRecoverer` that is designed to defer recovery of all calls that fail with the same status code. This class is meant to be subclassed in order to perform meaningful recovery.
///
/// `DeferredRetryRecoverer` will attempt recovery only for the first occurence of the call failing with the same status.
/// All subsequent calls for the same status code will wait until existing recovery finishes and will retry along with initial call.
///
/// In most cases subclasses should only override `attemptRecovery(for:,response,error,in:)` to provide custom recovery actions.
/// - Note: Default implementation does not recovery and behaves like `RetryRecoverer`.
open class DeferredRetryRecoverer: RetryRecoverer {
    
    /// Calls pending recovery for the same status code.
    private var recoveringCalls: [HTTPStatusCode: [RecoveryCompletion]] = [:]
    
    public override func recover(call: AnyRequestCall, response: HTTPURLResponse?, error: URLError?, in service: AnyNetworkService, _ completion: @escaping RecoveryCompletion) {
        guard let status = response?.statusCode else { return completion(false) }
        
        // Check if there is already pending recovery for given status.
        if recoveringCalls[status] != nil {
            // If there is, then store retry completion in the pending queue for that status.
            recoveringCalls[status]?.append(completion)
        } else {
            // If there is no recoveries pending for given status then attempt one.
            recoveringCalls[status] = [completion]
            
            attemptRecovery(for: call, response: response, error: error, in: service) { [weak self] isRecovered in
                self?.recoveringCalls[status]?.forEach { $0(isRecovered) }
                self?.recoveringCalls[status] = nil
            }
        }
    }
    
    /// Performs an attempt to recover given `call` after encountering an error.
    ///
    /// Subclasses should override this method to perform custom actions needed for recovery.
    /// Make sure to call `compltion` with flag indicating whether recovery was successful or not.
    /// - Parameter call: A request call that encountered an error.
    /// - Parameter response: An `HTTPURLResponse` received along with error.
    /// - Parameter error: An `URLError` describing occurred error.
    /// - Parameter completion: `RecoveryCompletion` closure that is called with flag indicating whether recovery was successful or not.
    open func attemptRecovery(for call: AnyRequestCall, response: HTTPURLResponse?, error: URLError?, in service: AnyNetworkService, _ completion: @escaping RecoveryCompletion) {
        completion(true)
    }
}
