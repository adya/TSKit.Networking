// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation

/// An object that intercepts all responses that network service receives.
public protocol AnyNetworkServiceInterceptor: class {

    /// Intercepts received response and determines whether it should be propagated or not.
    /// - Parameter call: Request call associated with the `response`.
    /// - Parameter response: Response headers received by service.
    /// - Parameter body: Response body if exists.
    /// - Returns: `true` if response should be processed and propagated, otherwise `false`.
    func intercept(call: AnyRequestCall, response: HTTPURLResponse, body: Any?) -> Bool
    
    /// Intercepts calls before is executes and determines whether it should be perofrmed or rejected.
    /// - Parameter call: Request call being prepared.
    /// - Returns: `true` if request call should be performed, otherwise `false`.
    func intercept(call: AnyRequestCall) -> Bool
}

// MARK: - Defaults
public extension AnyNetworkServiceInterceptor {
    
    func intercept(call: AnyRequestCall, response: HTTPURLResponse, body: Any?) -> Bool { true }
    
    func intercept(call: AnyRequestCall) -> Bool { true }
}
