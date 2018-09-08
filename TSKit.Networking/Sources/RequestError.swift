import Foundation

/**
 Defines set of handles error.
 
 - Requires:    iOS  [2.0; 8.0)
 - Requires:    Swift 2+
 - Version:     1.0
 - Since:       10/30/2016
 - Author:      AdYa
 */
public enum RequestError: Error {
    
    /// Remote service could not process `Request` because of unauthorized action.
    case unauthorized
    
    /// Given `Request` object is not valid to be sent.
    case invalidRequest
    
    /// Actual response has type different from specified `ResponseKind`. Therefore couldn't be handled by `Response`.
    case invalidResponseKind
    
    /// Remote service correctly processed `Request`, but responded with an error.
    case failedRequest
    
    /// Response has unacceptable status code.
    case validationError(ErrorResponse)
    
    /// Status code of the error.
    public var code: Int {
        switch self {
        case .invalidResponseKind: return 99
        case .invalidRequest: return 400
        case .unauthorized: return 401
        case .failedRequest: return 502
        case .validationError: return 520
        }
    }
}

extension RequestError: Hashable {
    
    public var hashValue: Int {
        return code.hashValue
    }
    
    public static func ==(lhs: RequestError, rhs: RequestError) -> Bool {
        return lhs.code == rhs.code
    }
}
