// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2019. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation

/// Object that provides an interface for construction of `AnyRequestCall` object.
/// - Note: Builder resets itself after making a call.
public protocol AnyRequestCallBuilder: class {

    init(request: AnyRequestable)

    /// Specifies `DispatchQueue` to which handler and progress closures will be dispatched.
    /// - Returns: Self.
    func dispatch(to queue: DispatchQueue) -> Self

    /// Registers specified `handler` for response of given type.
    /// - Parameter response: Expected type of the response.
    /// - Parameter statuses: A sequence of HTTP response status codes that is valid for given response type.
    /// - Parameter handler: A closure that receives deserialized response object.
    /// - Returns: Self.
    func response<ResponseType, StatusSequenceType>(_ response: ResponseType.Type,
                                                    forStatuses statuses: StatusSequenceType,
                                                    handler: @escaping ResponseResultCompletion<ResponseType>) -> Self where ResponseType: AnyResponse, StatusSequenceType: Sequence, StatusSequenceType.Element == Int

    /// Registers specified `handler` for response of given type.
    /// - Parameter response: Expected type of the response.
    /// - Parameter statuses: A sequence of HTTP response status codes that is valid for given response type.
    /// - Parameter handler: A closure that receives deserialized response object.
    /// - Returns: Self.
    func response<ResponseType>(_ response: ResponseType.Type,
                                forStatuses statuses: Int...,
                                handler: @escaping ResponseResultCompletion<ResponseType>) -> Self where ResponseType: AnyResponse

    /// Registers specified `handler` for response of given type.
    /// - Parameter response: Expected type of the response.
    /// - Parameter handler: A closure that receives deserialized response object.
    /// - Returns: Self.
    func response<ResponseType>(_ response: ResponseType.Type,
                                handler: @escaping ResponseResultCompletion<ResponseType>) -> Self where ResponseType: AnyResponse

    /// Specifies a `closure` to be called periodically with progress updates as data is read from a server.
    /// - Parameter closure: The code to be executed periodically as data is read from the server.
    /// - Parameter progress: An object that conveys ongoing progress for a given request.
    /// - Returns: Self.
    func progress(_ closure: @escaping (_ progress: Progress) -> Void) -> Self

    /// Makes configured `AnyRequestCall` object.
    /// - Returns: Constructed object.
    func make() -> AnyRequestCall?
}
