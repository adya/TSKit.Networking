// - Since: 06/11/2021
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation

/// Recoverer will attempt to recover failing requests by performing custom actions.
public protocol AnyNetworkServiceRecoverer: AnyObject {
    
    /// Determines whether recoverer can recover `given` with provided `HTTPURLResponse` and `URLError`.
    ///
    /// - Returns: Decision for recovery.
    func canRecover(call: AnyRequestCall, response: HTTPURLResponse?, error: URLError?, in service: AnyNetworkService) -> Bool
    
    func recover(call: AnyRequestCall, response: HTTPURLResponse?, error: URLError?, in service: AnyNetworkService, _ completion: @escaping RecoveryCompletion)
}

public typealias RecoveryCompletion = (Bool) -> Void
