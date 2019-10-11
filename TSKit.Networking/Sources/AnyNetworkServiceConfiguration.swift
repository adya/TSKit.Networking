// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2019. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation

/// Defines configurable properties for `AnyNetworkService`
public protocol AnyNetworkServiceConfiguration {

    /// Any default headers which must be attached to each request.
    var headers: [String : String]? { get }

    /// Host url used for each request, unless last one will explicitly override it.
    var host: String { get }

    /// Custom session configuration object to configure underlying `URLSession`.
    /// Defaults to the `default` session configuration object.
    var sessionConfiguration: URLSessionConfiguration { get }

}

public extension AnyNetworkServiceConfiguration {

    var headers: [String : String]? {
        return nil
    }

    var sessionConfiguration: URLSessionConfiguration {
        return .default
    }
}
