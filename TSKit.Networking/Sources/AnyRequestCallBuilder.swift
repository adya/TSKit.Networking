import Foundation

/// Object that provides an interface for construction of `AnyRequestCall` object.
public protocol AnyRequestCallBuilder: class {

    init(request: AnyRequest)

    func dispatch(to queue: DispatchQueue) -> Self

    func response<ResponseType, StatusSequenceType>(_ response: ResponseType.Type,
                                                    forStatuses statuses: StatusSequenceType,
                                                    handler: @escaping ResponseResultCompletion<ResponseType>) -> Self where ResponseType: AnyResponse, StatusSequenceType: Sequence, StatusSequenceType.Element == UInt

    func response<ResponseType>(_ response: ResponseType.Type,
                                forStatuses statuses: UInt...,
                                handler: @escaping ResponseResultCompletion<ResponseType>) -> Self where ResponseType: AnyResponse

    /// Attaches handler for any response
    func response<ResponseType>(_ response: ResponseType.Type,
                                handler: @escaping ResponseResultCompletion<ResponseType>) -> Self where ResponseType: AnyResponse

    func make() -> AnyRequestCall
}
