/** 
 Configuration of a network request.
 
 - Requires:    iOS 2.0+
 - Requires:    Swift 2+
 - Version:     3.0
 - Since:       10/30/2016
 - Author:      Arkadii Hlushchevskyi
 */
public protocol AnyRequest: CustomStringConvertible {

    /// HTTP Method of the request.
    var method: RequestMethod { get }

    /** Encoding method used to encode request parameters.
     - Note: Default = determined by HTTP Method.
     * .GET, .DELETE -> .URL
     * .POST, .PUT, .PATCH -> JSON
     */
    var encoding: RequestEncoding { get }

    /// Overridden host which will be used instead of default host specified in network configuration.
    /// - Note: Default = nil.
    var host: String? { get }

    /// Resource path relative to the host.
    var path: String { get }

    /// Set of status codes acceptable by this request.
    /// - Note: Default = 200..<300
    var statusCodes: Set<Int> { get }

    /// Parameters of the request.
    var parameters: [String : Any]? { get }

    /// Overridden encoding methods for specified parameters.
    /// Allows to encode several params in a different way.
    /// - Note: Default = nil.
    var parametersEncodings: [String : RequestEncoding]? { get }

    /// Any custom headers that must be attached to that request.
    /// - Note: Default = nil.
    var headers: [String : String]? { get }
}

/** 
 Defines supported HTTP Methods.
 
 - Requires:    iOS  2.0+
 - Requires:    Swift 2+
 - Version:     2.1
 - Since:       10/30/2016
 - Author:      Arkadii Hlushchevskyi
 */
public enum RequestMethod {
    case get
    case post
    case delete
    case put
    case patch
}

/** 
 Defines how request parameters should be encoded.
 
 - Requires:    iOS  2.0+
 - Requires:    Swift 2+
 - Version:     2.1
 - Since:       10/30/2016
 - Author:      Arkadii Hlushchevskyi
 */
public enum RequestEncoding {

    /// Encoded as url query.
    case url

    /// Encoded as json and inserted into request body.
    case json

    /// Encoded as parts of multipart-form data.
    case formData
}

// MARK: - Defaults
public extension AnyRequest {

    public var baseUrl: String? {
        return nil
    }

    public var headers: [String : String]? {
        return nil
    }

    public var encoding: RequestEncoding {
        switch self.method {
        case .get, .delete: return .url
        case .post, .put, .patch: return .json
        }
    }

    public var statusCodes: Set<Int> {
        return Set(200..<300)
    }

    var parametersEncodings: [String : RequestEncoding]? {
        return nil
    }

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

