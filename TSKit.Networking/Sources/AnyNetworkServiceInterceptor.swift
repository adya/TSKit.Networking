/// - Since: 01/20/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2018. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

/// An object that intercepts all responses that network service receives.
public protocol AnyNetworkServiceInterceptor: class {

    /// Intercepts received response and determines whether it should be propagated or not.
    /// - Parameter call: Request call associated with the `response`.
    /// - Parameter response: Response headers received by service.
    /// - Parameter body: Response body if exists.
    /// - Returns: `true` if response should be processed and propagated, otherwise `false`.
    func intercept(call: AnyRequestCall, response: HTTPURLResponse, body: Any?) -> Bool
}
