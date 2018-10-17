import Dispatch

/**
 Network service used to perform and manage lifecycle of multiple service calls.

 - Version:     3.0
 - Since:       10/15/2018
 - Author:      Arkadii Hlushchevskyi
 */
public protocol AnyNetworkService: class {

    /// The background completion handler closure provided by the `UIApplicationDelegate`'s `application:handleEventsForBackgroundURLSession:completionHandler:` method.
    /// By setting the background completion handler, the `SessionDelegate`'s `sessionDidFinishEventsForBackgroundURLSession` closure implementation will automatically call the handler.
    var backgroundSessionCompletionHandler: (() -> Void)? { get set }

    /// Mandatory initializer with configuration object.
    /// - Parameter configuration: An object that is used to configure `AnyNetworkService` for specific server.
    init(configuration: AnyNetworkServiceConfiguration)

    /// Interceptors that receives each response.
    /// - Note: Response will be skipped if at least one of interceptors return `false`.
    var interceptors: [AnyNetworkServiceInterceptor]? { get set }

    /// Creates a requset call builder that constructs a valid `AnyRequestCall` object supported by the service.
    /// - Parameter request: A request for which a call will be constructed.
    /// - Returns: A builder object that can contruct a call for specified `request`.
    func builder(for request: AnyRequestable) -> AnyRequestCallBuilder

    /**
     Executes a request call.
     - Parameter calls: Request calls to be executed.
     - Parameter option: An option that determines how multiple calls should be executed.
     - Parameter completion: Completion closure to be called after all requests completed.
     */
    func request(_ call: [AnyRequestCall],
                 option: ExecutionOption,
                 queue: DispatchQueue,
                 completion: RequestCompletion?)

    /**
     Executes a request call.
     - Parameter calls: Request calls to be executed.
     - Parameter option: An option that determines how multiple calls should be executed.
     - Parameter completion: Completion closure to be called after request completed.
     */
    func request(_ calls: AnyRequestCall...,
                 option: ExecutionOption,
                 queue: DispatchQueue,
                 completion: RequestCompletion?)
}

public extension AnyNetworkService {

    func request(_ requestCalls: [AnyRequestCall],
                 option: ExecutionOption = .executeAsynchronously(ignoreFailures: false),
                 queue: DispatchQueue = .global(),
                 completion: RequestCompletion? = nil) {
        self.request(requestCalls, option: option, queue: queue, completion: completion)
    }

    func request(_ requestCalls: AnyRequestCall...,
                 option: ExecutionOption = .executeAsynchronously(ignoreFailures: false),
                 queue: DispatchQueue = .global(),
                 completion: RequestCompletion? = nil) {
        self.request(requestCalls, option: option, queue: queue, completion: completion)
    }
}
