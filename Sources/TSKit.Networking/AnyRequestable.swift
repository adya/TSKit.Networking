// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation

/// An object that describes a request to be performed.
public protocol AnyRequestable: CustomStringConvertible, CustomDebugStringConvertible {

    /// HTTP Method of the request.
    var method: RequestMethod { get }

    /// Encoding method used to encode request parameters.
    /// - Note: Default encoding is determined by HTTP Method:
    /// * GET, HEAD, DELETE, OPTIONS, TRACE -> .url
    /// * POST, PUT, PATCH -> .json
    var encoding: ParameterEncoding { get }

    /// Overriden encoding options that will be used instead of the one provided in `AnyNetworkServiceConfiguration`.
    ///
    /// Encoding options that customizes a way parameters values will be encoded.
    /// - Note: Optional.
    var encodingOptions: ParameterEncoding.Options? { get }
    
    /// Overridden host which will be used instead of default host specified in `AnyNetworkServiceConfiguration`.
    /// - Note: Optional.
    var host: String? { get }

    /// Resource path relative to the host.
    var path: String { get }

    /// Parameters of the request.
    /// - Note: Optional.
    var parameters: [String : Any]? { get }

    /// Overridden encoding methods for specified parameters.
    /// Allows to encode several params in a different way.
    /// - Note: Optional.
    // var parametersEncodings: [String : ParameterEncoding]? { get }

    /// Custom headers to be attached to request.
    /// - Note: If header already defined in `AnyNetworkSercideConfiguration`
    ///         used to configure a service that will execute the request,
    ///         request's headers will override configuration's headers.
    /// - Note: Optional.
    var headers: [String : String]? { get }
    
    /// Header names that are considered sensitive and should be excluded from request's description.
    ///
    /// Headers listed as sensitive are excluded from default `description` representation of `AnyRequestable` objects.
    /// - Note: This does not affect `debugDescription` representation, which will list all headers.
    var sensitiveHeaders: Set<String>? { get }
    
    /// Parameter names that are considered sensitive and should be excluded from request's description.
    ///
    /// Parameters listed as sensitive are excluded from default `description` representation of `AnyRequestable` objects.
    /// - Note: This does not affect `debugDescription` representation, which will list all parameters.
    var sensitiveParameters: Set<String>? { get }
    
    /// A set of status codes that are valid for this request.
    ///
    /// Any responses with status codes outside of that set will be considered as error and will trigger error handler.
    /// Defaults to [200; 299] statuses.
    /// - Note: If request call has associated response with status code that is not included in this set it will expand this range and response will be handled as usual.
    ///         Use `AnyRequestCall.validStatuses` to get a list of all statuses that are allowed for the call.
    var statusCodes: Set<HTTPStatusCode> { get }
    
    /// Timeout interval in seconds for the request.
    /// Request's `timeoutInterval` overwrites the one from configuration.
    /// - Note: Oprional. When `nil` service will use configuration's `timeoutInterval` instead.
    var timeoutInterval: TimeInterval? { get }
    
    /// Maximum number of attempts that failed request can be retried before.
    /// Defaults to `nil` which indicates that `AnyNetworkServiceRecoverer` that will perform recovery will determine that value.
    var maximumRecoveryAttempts: UInt? { get }
    
    /// Set of errors that are considered to be recoverable with multiple retries.
    /// Defaults to `nil` which indicates that `AnyNetworkServiceRecoverer` that will perform recovery will determine that value.
    var recoverableFailures: Set<URLError.Code>? { get }
    
    /// Set of HTTP response statuses that are considered recoverable.
    /// Defaults to `nil` which indicates that `AnyNetworkServiceRecoverer` that will perform recovery will determine that value.
    var recoverableStatuses: Set<HTTPStatusCode>? { get }
}

// MARK: - Defaults
public extension AnyRequestable {

    var host: String? {
        nil
    }

    var headers: [String : String]? {
        nil
    }

    var parameters: [String : Any]? {
        nil
    }
    
    var encodingOptions: ParameterEncoding.Options? {
        nil
    }

    var encoding: ParameterEncoding {
        switch self.method {
            case .get, .head, .delete, .options, .trace: return .url
            case .post, .put, .patch: return .json
        }
    }
    
    var timeoutInterval: TimeInterval? { nil }
    
    var maximumRecoveryAttempts: UInt? { nil }
    
    var recoverableFailures: Set<URLError.Code>? { nil }
        
    var recoverableStatuses: Set<HTTPStatusCode>? { nil }

    var statusCodes: Set<HTTPStatusCode> { Set(200..<300) }
    
    var sensitiveHeaders: Set<String>? { nil }
    
    var sensitiveParameters: Set<String>? { nil }

    // var parametersEncodings: [String : ParameterEncoding]? {
    //     nil
    // }

    var description: String {
        let sensitiveDataReplacer = "-- Redacted --"
        
        var descr = "\(self.method) '"
        if let baseUrl = self.host {
            descr += "\(baseUrl)/"
        }
        descr += "\(self.path)'"
        if var headers = self.headers {
            sensitiveHeaders?.forEach {
                headers[$0] = sensitiveDataReplacer
            }
            descr += "\nHeaders:\n\(headers)"
        }
        if var params = self.parameters {
            sensitiveParameters?.forEach {
                params[$0] = sensitiveDataReplacer
            }
            descr += "\nParameters:\n\(params)"
        }
        return descr
    }
    
    var debugDescription: String {
        var descr = "\(self.method) '"
        if let baseUrl = self.host {
            descr += "\(baseUrl)/"
        }
        descr += "\(self.path)'"
        if let headers = self.headers {
            descr += "\nHeaders:\n\(headers)"
        }
        if let params = self.parameters {
            descr += "\nParameters:\n\(params)"
        }
        return descr
    }
}

