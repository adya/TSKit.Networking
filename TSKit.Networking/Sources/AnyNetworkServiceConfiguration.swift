/**
 Defines configurable properties for `AnyNetworkService`

 - Version:     3.0
 - Since:       10/15/2018
 - Author:      Arkadii Hlushchevskyi
 */
public protocol AnyNetworkServiceConfiguration {

    /// Any default headers which must be attached to each request.
    var headers: [String : String]? { get }

    /// Host url used for each request, unless last one will explicitly override it.
    var host: String { get }

    /// Custom session configuration object to configure underlying `URLSession`.
    /// Defaults to `nil` that means the `default` session configuration object will be used.
    var sessionConfiguration: URLSessionConfiguration? { get }

}

public extension AnyNetworkServiceConfiguration {

    var headers: [String : String]? {
        return nil
    }

    var sessionConfiguration: URLSessionConfiguration? {
        return  nil
    }
}
