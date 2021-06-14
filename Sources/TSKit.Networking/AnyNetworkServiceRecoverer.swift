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
    func canRecover(call: AnyRequestCall, response: HTTPURLResponse?, error: URLError?, in service: AnyNetworkService) -> Bool
    
    /// Performs recovery of the `AnyRequestCall` when it encounters an error that this recoverer can handle.
    ///
    /// This method is getting called for every `AnyRequestCall` that fails for any reason and is considered recoverable (e.g. `canRecover` returns `true`).
    /// - Important: The recovery process does not block other calls even if they fail for the same reason. It is up to specific implementations of `AnyNetworkServiceRecoverer` to handle multiple calls at once. See `DeferredRetryRecoverer` for example.
    /// - Parameter call: A request call that encountered an error.
    /// - Parameter response: An `HTTPURLResponse` received along with error.
    /// - Parameter error: An `URLError` describing occurred error.
    /// - Parameter service: An instance of `AnyNetworkService` that is processing the call.
    /// - Parameter completion: `RecoveryCompletion` closure that is called with flag indicating whether recovery was successful or not.
    func recover(call: AnyRequestCall, response: HTTPURLResponse?, error: URLError?, in service: AnyNetworkService, _ completion: @escaping RecoveryCompletion)
}

/// A closure that is called to notify about recovery completion and whether or not it was successful.
/// - Parameter isRecovered: Flag indicating whether recovery completed successfully or not.
public typealias RecoveryCompletion = (_ isRecovered: Bool) -> Void
