// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation

/// An empty response object received from service.
public protocol AnyResponse {

    /// Expected type of response to be received from service.
    /// - Note: Defaults to `.json`.
    static var kind: ResponseKind { get }

    /// Initializes response object with given HTTP `response` and response's `body` that is converted to the type corresponding to `kind` of `AnyResponse`.
    init(response: HTTPURLResponse, body: Any?) throws

    /// HTTP response returned by a service.
    var response: HTTPURLResponse { get }
}
