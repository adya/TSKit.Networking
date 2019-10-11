// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2019. Arkadii Hlushchevskyi.
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

    /// Overridden host which will be used instead of default host specified in network configuration.
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
}

// MARK: - Defaults
public extension AnyRequestable {

    var host: String? {
        return nil
    }

    var headers: [String : String]? {
        return nil
    }

    var parameters: [String : Any]? {
        return nil
    }

    var encoding: ParameterEncoding {
        switch self.method {
        case .get, .head, .delete: return .url
        case .post, .put, .patch: return .json
        }
    }

    var statusCodes: Set<Int> {
        return Set(200..<300)
    }

    // var parametersEncodings: [String : ParameterEncoding]? {
    //     return nil
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

