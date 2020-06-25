// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation

public protocol AnyNetworkServiceError: Error {
    
    /// Original request ffor which error happened.
    var request: AnyRequestable { get }
    
    /// HTTP response that was received along with error.
    var response: HTTPURLResponse? { get }
    
    /// Additional underlying error produced by the service.
    var error: Error? { get }
    
    /// Reason why the error was produced.
    var reason: NetworkServiceErrorReason { get }
    
    /// Initializes an error object with all the information describing error.
    /// - Note: Unlike similar `AnyResponse` initialization the `AnyNetworkServiceError` is guaranteed to succeed even if body was unacceptable for custom `AnyNetworkServiceError`.
    init(request: AnyRequestable,
         response: HTTPURLResponse?,
         error: Error?,
         reason: NetworkServiceErrorReason,
         body: Any?)
}

/// An object that contains the information about request failure.
public protocol AnyNetworkServiceBodyError: AnyNetworkServiceError {
    
    /// Type of the object that is expected in error responses from server.
    associatedtype ObjectType
    
    /// If service received any response from server with an error, body will contain HTTP response's body provided.
    var body: ObjectType? { get }
}

/// An object that provides context of failed error.
public struct NetworkServiceError: Error, AnyNetworkServiceBodyError {
    
    public let request: AnyRequestable
    
    /// HTTP response that was received along with error.
    public let response: HTTPURLResponse?
    
    /// Raw content of the response's body if it was present.
    public let body: Any?
    
    public let error: Error?
    
    public let reason: NetworkServiceErrorReason
    
    public init(request: AnyRequestable,
                response: HTTPURLResponse?,
                error: Error?,
                reason: NetworkServiceErrorReason,
                body: Any?) {
        self.request = request
        self.response = response
        self.error = error
        self.body = body
        self.reason = reason
    }
}

public enum NetworkServiceErrorReason {
    
    /// An error occured due to request has been skipped due to interceptors.
    case skipped
    
    /// An error occured due to server responded with HTTP error.
    case httpError
    
    /// An error occured before service could get any response from server.
    case unreachable
    
    /// An error occured due to provided `AnyResponse` type failed to initialize.
    case deserializationFailure
    
    /// An error occured due to service failed to encode given request.
    case encodingFailure
}


//public enum NetworkServiceErrorReason {
//
//    /// An error occured due to request has been skipped due to interceptors.
//    case skipped
//
//    /// An error occured due to server responded with HTTP error.
//    /// - Parameter httpResponse: HTTP response header that was provided by the server.
//    case httpError(httpResponse: HTTPURLResponse)
//
//    /// An error occured due to provided `AnyResponse` type failed to initialize.
//    /// - Parameter body: Body that caused the error.
//    case deserializationFailure(body: Any?)
//
//    /// An error occured due to service failed to encode given request.
//    /// - Parameter request: Request that failed to encode.
//    case encodingFailure(request: AnyRequestable)
//}
