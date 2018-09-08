/**
 RequestCall represents a single request call with configured `Request` object and defined type of expected `Response` object.

 - Requires:    iOS  [2.0; 8.0)
 - Requires:    Swift 2+
 - Version:     2.1
 - Since:       10/30/2016
 - Author:      AdYa
 */

import Dispatch

public class RequestCall: AnyRequestCall {

    /// `Request` to be called.
    public let request: Request

    /// `Request` completion called once the request is completed.
    public var completion: AnyResponseResultCompletion?

    /// Generalized type of the `Response`.
    /// - Note: Returns actual generic type.
    public var responseType: AnyResponse.Type

    /// Custom queue for completion.
    public var queue: DispatchQueue

    public var token: AnyCancellationToken?

    /// - Parameter request: Configured Request object.
    /// - Parameter responseType: Type of expected Response object.
    /// - Parameter completion: Closure to be called upon receiving response.
    public init<ResponseType: AnyResponse>(request: Request,
                                           responseType: ResponseType.Type,
                                           queue: DispatchQueue = DispatchQueue.global(),
                                           completion: ((ResponseResult<ResponseType>) -> Void)? = nil) {
        self.request = request
        self.responseType = responseType
        self.queue = queue
        self.completion = { res in
            switch res {
            case .success(let response): completion?(.success(response: response as! ResponseType))
            case .failure(let error): completion?(.failure(error: error))
            }
        }
    }

    public func cancel() {
        token?.cancel()
        token = nil
    }
}

/**
 Represents common interface of the RequestCall. Used intensively to handle array of different `RequestCall`'s.
 
 - Requires:    iOS  [2.0; 8.0)
 - Requires:    Swift 2+
 - Version:     2.1
 - Since:       10/30/2016
 - Author:      AdYa
 */
public protocol AnyRequestCall: class {

    /// `Request` to be called.
    var request: Request { get }

    /// Generalized `Request` completion called once the request is completed.
    /// - Note: Forwards calls to actual completion with generic type.
    var completion: AnyResponseResultCompletion? { get }

    /// Generalized type of the `Response`.
    /// - Note: Returns actual generic type.
    var responseType: AnyResponse.Type { get }

    /// Custom queue for completion.
    var queue: DispatchQueue { get }

    /// Token to be set by manager when request will be processed.
    var token: AnyCancellationToken? { get set }

    /// Cancels request at any state.
    /// - Note: Calling this method will ensure that `completion` won't be triggered.
    func cancel()

}

public typealias AnyResponseResultCompletion = (AnyResponseResult) -> Void
