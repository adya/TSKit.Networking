// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
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

    /// When session is configured for background execution, you may specify a path
    /// to the directory where session will save temporary files with responses.
    /// - Note: Optional.
    /// - Note: **Defaults** to system's `temporaryDirectory`.
    var sessionTemporaryFilesDirectory: URL? { get }
    
    /// Encoding options that customizes a way parameters values will be encoded.
    var encodingOptions: ParameterEncoding.Options { get }
    
    /// Default timeout interval in seconds for all requests.
    /// - Note: When set to `nil` default values from `URLSession` will be used.
    var timeoutInterval: TimeInterval? { get }
    
    /// HTTP Methods that should be retried according to the `configuration`.
    ///
    /// Defaults to `nil` which will fall back to all idempotent methods:
    /// - GET
    /// - HEAD
    /// - DELETE
    /// - OPTIONS
    /// - PUT
    /// - TRACE
    var retriableMethods: Set<RequestMethod> { get }
    
    /// Number of attempts that request should be retried.
    /// Defaults to `nil` which disables retrying.
    var retryAttempts: UInt? { get }
    
    /// Set of errors that are considered to be recoverable with multiple retries.
    /// Defaults to `nil` which falls back to predefined values.
    /// - Note: `retriableFailures` from `Request`s overwrite the same property from `configuration`.
    var retriableFailures: Set<URLError.Code>? { get }
}

public extension AnyNetworkServiceConfiguration {

    var timeoutInterval: TimeInterval? { nil }
    
    var retryAttempts: UInt? { nil }
    
    var retriableFailures: Set<URLError.Code>? { nil }
    
    var retriableMethods: Set<RequestMethod> { [.get, .head, .delete, .options, .put, .trace] }
    
    var headers: [String : String]? {
        nil
    }

    var sessionConfiguration: URLSessionConfiguration {
        .default
    }
    
    var encodingOptions: ParameterEncoding.Options {
        .init()
    }
}
