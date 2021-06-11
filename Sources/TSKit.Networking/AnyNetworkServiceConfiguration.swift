// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
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
    
    /// Set of HTTP response statuses that are considered recoverable.
    /// - Note: Statuses defined in `AnyRequestable` take priority over statuses in `configuration`.
    var recoverableStatuses: Set<Int>? { get }
    
    /// Number of attempts that request can be recovered.
    /// Defaults to `1`.
    var recoveryAttempts: UInt { get }
}

public extension AnyNetworkServiceConfiguration {

    var timeoutInterval: TimeInterval? { nil }
        
    var recoverableStatuses: Set<Int>? { nil }
    
    var headers: [String : String]? { nil }

    var sessionConfiguration: URLSessionConfiguration { .default }
    
    var encodingOptions: ParameterEncoding.Options { .init() }
    
    var recoveryAttempts: UInt { 1 }
}
