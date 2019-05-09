/// - Since: 01/20/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2018. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

/// An empty response object received from service.
public protocol AnyResponse {

    /// Expected type of response to be received from service.
    /// - Note: Defaults to `.json`.
    static var kind: ResponseKind { get }

    init?(response: HTTPURLResponse, body: Any?)

    /// HTTP response returned by a service.
    var response: HTTPURLResponse { get }
}
