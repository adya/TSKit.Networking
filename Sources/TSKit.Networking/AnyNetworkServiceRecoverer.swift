// - Since: 06/11/2021
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation

/// Recoverer will attempt to recover failing requests by performing custom actions.
public protocol AnyNetworkServiceRecoverer: AnyObject {
    
    /// Determines whether recoverer can recover given `call` that encountered an error with provided `HTTPURLResponse` and `URLError`.
    ///
    /// This method is getting called for every `AnyRequestCall` that fails for any reason to determine
    /// if it can be recovered and retried afterwards.
    /// - Parameter call: A request call that encountered an error.
    /// - Parameter response: An `HTTPURLResponse` received along with error.
    /// - Parameter error: An `URLError` describing occurred error.
    /// - Parameter service: An instance of `AnyNetworkService` that is processing the call.
    /// - Returns: Decision for recovery.
    func canRecover(call: AnyRequestCall,
                    response: HTTPURLResponse?,
                    error: URLError?,
                    in service: AnyNetworkService) -> Bool
    
    /// Performs recovery of the `AnyRequestCall` when it encounters an error that this recoverer can handle.
    ///
    /// This method is getting called for every `AnyRequestCall` that fails for any reason and is considered recoverable (e.g. `canRecover` returns `true`).
    /// - Important: The recovery process does not block other calls even if they fail for the same reason. It is up to specific implementations of `AnyNetworkServiceRecoverer` to handle multiple calls at once. See `DeferredRetryRecoverer` for example.
    /// - Parameter call: A request call that encountered an error.
    /// - Parameter response: An `HTTPURLResponse` received along with error.
    /// - Parameter error: An `URLError` describing occurred error.
    /// - Parameter service: An instance of `AnyNetworkService` that is processing the call.
    /// - Parameter completion: `RecoveryCompletion` closure that is called with flag indicating whether recovery was successful or not.
    func recover(call: AnyRequestCall,
                 response: HTTPURLResponse?,
                 error: URLError?,
                 in service: AnyNetworkService,
                 _ completion: @escaping RecoveryCompletion)
    
    /// Provides required updates for a given `URLRequest` after recovering associated call.
    ///
    /// This method is called for each recovered `AnyRequestCall` before it will be retried.
    /// Previously failed `AnyRequestCall`s are already encoded into `URLRequest` and remain in that state,
    /// so to avoid rebuilding whole `URLRequest` (which might be expensive) `AnyNetworkService` gives `AnyNetworkServiceRecoverer` a chance to modify each `URLRequest` that will be retried.
    /// - Note: Default recoverers do not update requests.
    /// - Parameter request: The `URLRequest` to be updated before it will be retried.
    /// - Parameter call: Associated `AnyRequestCall` that was recovered.
    /// - Parameter service: An instance of `AnyNetworkService` that is processing the call.
    func update(request: inout URLRequest,
                afterRecovering call: AnyRequestCall,
                in service: AnyNetworkService)
}

public extension AnyNetworkServiceRecoverer {
    
    func update(request: inout URLRequest,
                afterRecovering call: AnyRequestCall,
                in service: AnyNetworkService) {}
}

/// A closure that is called to notify about recovery completion and whether or not it was successful.
/// - Parameter isRecovered: Flag indicating whether recovery completed successfully or not.
public typealias RecoveryCompletion = (_ isRecovered: Bool) -> Void
