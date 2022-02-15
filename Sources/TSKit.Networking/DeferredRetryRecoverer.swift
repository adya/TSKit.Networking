// - Since: 06/11/2021
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation
import TSKit_Core

/// A variation of `RetryRecoverer` that is designed to defer recovery of all calls that match the same criteria based on HTTP response, status code and error.
/// This class is meant to be subclassed in order to perform meaningful recovery.
///
/// At all times there is only one recovery process for the same criteria: the first failing request that matches the criteria initiates the recovery.
/// All subsequent calls that fail for the same reason will wait until existing recovery is finished, and then will be retried in the same order as they failed.
///
/// Subclasses should override `attemptRecovery(for:response:error:in:)` instead of `recover(call:response:error:in:_:)` to provide custom recovery actions, since `DeferredRetryRecoverer` relies on its implementation of this method.
///
/// - Note: Default implementation does not perform any recovery and behaves like `RetryRecoverer`.
open class DeferredRetryRecoverer: RetryRecoverer {
    
    /// A delegate that is notified about recovery stages.
    public weak var delegate: DeferredRetryRecovererDelegate?
    
    /// Calls pending recovery.
    @Synchronized(synchronizer: SemaphoreSynchronizer())
    private var recoveringCalls: [RecoveryCompletion] = []
    
    public override func recover(call: AnyRequestCall, response: HTTPURLResponse?, error: URLError?, in service: AnyNetworkService, _ completion: @escaping RecoveryCompletion) {
        guard recoveringCalls.isEmpty else {
            delegate?.recoverer(self, didEnqueueRecoveryFor: call.request)
            return recoveringCalls.append(completion)
        }
        
        delegate?.recoverer(self, willStartRecoveryFor: call.request, with: response, error: error)
        recoveringCalls.append(completion)
        attemptRecovery(for: call, response: response, error: error, in: service) { [weak self] isRecovered in
            guard let self = self else { return }
            self.delegate?.recoverer(self, didFinishRecovery: isRecovered)
            self.$recoveringCalls.replace(with: []).forEach { $0(isRecovered) }
        }
    }
    
    /// Performs an attempt to recover given `call` after encountering an error.
    ///
    /// Subclasses should override this method to perform custom actions needed for recovery.
    /// - Important: Make sure to call `completion` with a flag indicating whether recovery was successful or not.
    ///
    /// - Note: Base implementation of this method does nothing and immediately reports successful recovery completion.
    ///
    /// - Parameter call: A request call that encountered an error.
    /// - Parameter response: An `HTTPURLResponse` received along with error.
    /// - Parameter error: An `URLError` describing occurred error.
    /// - Parameter completion: `RecoveryCompletion` closure that is called with flag indicating whether recovery was successful or not.
    open func attemptRecovery(for call: AnyRequestCall, response: HTTPURLResponse?, error: URLError?, in service: AnyNetworkService, _ completion: @escaping RecoveryCompletion) {
        completion(true)
    }
}

/// A delegate that is notified about recovery stages of `DeferredRetryRecoverer`.
public protocol DeferredRetryRecovererDelegate: AnyObject {
    
    /// This method is called when `recoverer` is about to start recovery process for the first failed request.
    /// - Parameter request: A request that has failed and will initiate recovery process.
    /// - Parameter response: HTTP response associated with the request if available.
    /// - Parameter error: Underlying error associated with the request.
    func recoverer(_ recoverer: DeferredRetryRecoverer,
                   willStartRecoveryFor request: AnyRequestable,
                   with response: HTTPURLResponse?,
                   error: URLError?)
    
    /// This method is called when `recoverer` receives a failed `request` during an already running recovery process.
    /// - Parameter request: A request that has failed and will be enqueued for retry once current recovery process succeeds.
    func recoverer(_ recoverer: DeferredRetryRecoverer,
                   didEnqueueRecoveryFor request: AnyRequestable)
    
    /// This method is called when `recoverer` finishes current recovery and is about to send all pending request to be retried.
    /// - Parameter isRecovered: Flag indicating whether recovery has finished successfully.
    func recoverer(_ recoverer: DeferredRetryRecoverer,
                   didFinishRecovery isRecovered: Bool)
    
}

// MARK: - Defaults
public extension DeferredRetryRecovererDelegate {
    
    func recoverer(_ recoverer: DeferredRetryRecoverer,
                   willStartRecoveryFor request: AnyRequestable,
                   with response: HTTPURLResponse?,
                   error: URLError?) {}
    
    func recoverer(_ recoverer: DeferredRetryRecoverer,
                   didEnqueueRecoveryFor request: AnyRequestable) {}
    

    func recoverer(_ recoverer: DeferredRetryRecoverer,
                   didFinishRecovery isRecovered: Bool) {}
}
