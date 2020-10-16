// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

/// An object that describes a request to be performed.
public protocol AnyRequestable: CustomStringConvertible {

    /// HTTP Method of the request.
    var method: RequestMethod { get }

    /// Encoding method used to encode request parameters.
    /// - Note: Default encoding is determined by HTTP Method:
    /// * GET, HEAD, DELETE -> .url
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
    
    /// A set of status codes that are valid for this request.
    /// Any responses with status codes outside of that set will be considered as error and will trigger error handler.
    /// - Note: If request call has associated response with status code that is not included in this set response will be handled as usual.
    var statusCodes: Set<Int> { get }
    
    /// Timeout interval in seconds for the request.
    /// Request's `timeoutInterval` overwrites the one from configuration.
    /// - Note: Oprional. When `nil` service will use configuration's `timeoutInterval` instead.
    var timeoutInterval: TimeInterval? { get }
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
        case .get, .head, .delete: return .url
        case .post, .put, .patch: return .json
        }
    }
    
    var timeoutInterval: TimeInterval? { nil }

    var statusCodes: Set<Int> { Set(200..<300) }

    // var parametersEncodings: [String : ParameterEncoding]? {
    //     nil
    // }

    var description: String {
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

