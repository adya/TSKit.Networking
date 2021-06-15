// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Dispatch

/// Network service used to perform and manage lifecycle of multiple service calls.
public protocol AnyNetworkService: AnyObject {

    /// The background completion handler closure provided by the `UIApplicationDelegate`'s
    /// `application:handleEventsForBackgroundURLSession:completionHandler:` method.
    /// By setting the background completion handler, the `SessionDelegate`'s
    /// `sessionDidFinishEventsForBackgroundURLSession` closure implementation will automatically call the handler.
    /// - Important: Background sessions **are not supported**. `TSKit.Networking` is designed for simple foreground networking.
    @available(*, deprecated, message: "Background sessions are not supported")
    var backgroundSessionCompletionHandler: (() -> Void)? { get set }

    /// Interceptors receiving each response.
    /// - Note: Response will be skipped if at least one of interceptors returned `false`.
    var interceptors: [AnyNetworkServiceInterceptor] { get set }
    
    /// Recoverer will attempt to recover failing requests by performing custom actions.
    ///
    /// `AnyNetworkService` uses recoverer's `canRecover(call:response:error:in:)` to determine suitable recoverer that will handle recovery.
    /// Order at which recoverers are placed in this array determines their priority. The first recoverer that will return `true` in `canRecover(call:response:error:in:)` will be responsible for recovering failing request.
    var recoverers: [AnyNetworkServiceRecoverer] { get set }

    /// Creates a request call builder that constructs a valid `AnyRequestCall` object supported by the service.
    /// - Parameter request: A request for which a call will be constructed.
    /// - Returns: A builder object that can construct a call for specified `request`.
    func builder(for request: AnyRequestable) -> AnyRequestCallBuilder

    /// Executes a request call.
    /// - Parameter calls: Request calls to be executed.
    /// - Parameter option: An option that determines how multiple calls should be executed.
    /// - Parameter completion: Completion closure to be called after all requests completed.
    func request(_ call: [AnyRequestCall],
                 option: ExecutionOption,
                 queue: DispatchQueue,
                 completion: RequestCompletion?)

    /// Executes a request call.
    /// - Parameter calls: Request calls to be executed.
    /// - Parameter option: An option that determines how multiple calls should be executed.
    /// - Parameter completion: Completion closure to be called after request completed.
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
