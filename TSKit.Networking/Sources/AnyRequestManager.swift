/**
 **Key features:**
 1. Highly configurable via configuration object.
 2. Sync multiple requests.
 3. Simple and obvious way to create request calls.
 
 - Requires:    iOS  [2.0; 8.0)
 - Requires:    Swift 2+
 - Version:     2.1
 - Since:       10/30/2016
 - Author:      AdYa
 */
public protocol AnyRequestManager: class {

    /// Closures to be called if specified errors occurred.
    var errorHandlers: [RequestError : () -> Void] { get set }

    /// Mandatory initializer with configuration object to set default properties.
    /// - Parameter configuration: An object containing custom properties.
    init(configuration: RequestManagerConfiguration)

    /**
     Executes a request call.
     - Parameter requestCalls: Request calls to be executed.
     - Parameter option: Defines advanced behavior of the `RequestManager`.
     - Parameter completion: Completion closure to be called after all requests completed.
     */
    func request(_ requestCalls: [AnyRequestCall], option: ExecutionOption, completion: RequestCompletion?)

    /**
     Executes a request call.
     - Parameter requestCall: Request call to be executed.
     - Parameter progressCompletion: Completion closure to be called if progress has changed.
     - Parameter completion: Completion closure to be called after request completed.
     */
    func request(_ requestCall: AnyRequestCall,
                 progressCompletion: RequestProgressCompletion?,
                 completion: RequestCompletion?)
}

public typealias RequestCompletion = (EmptyResult) -> Void

public typealias RequestProgressCompletion = (Float) -> Void

/// Defines advanced behavior of the `RequestManager` when dealing with multiple requests.
public enum ExecutionOption {

    /// Indicates that `AnyRequestManager` should execute each request call synchronously.
    /// - Parameter ignoreFailures: Indicates whether the manager should abort when any error occurred or continue
    /// execution.
    case executeSynchronously(ignoreFailures: Bool)

    /// Indicates that `AnyRequestManager` should execute all request calls asynchronously.
    /// - Parameter ignoreFailures: Indicates whether the manager should abort when any error occurred or continue
    /// execution.
    case executeAsynchronously(ignoreFailures: Bool)
}

/// Defines configurable properties of `RequestManager`
public protocol RequestManagerConfiguration {

    /// Any default headers which must be attached to each request
    var headers: [String : String]? { get }

    /// Base url used for each request, unless the last one will explicitly override it.
    var baseUrl: String { get }

    /// Default timeout for each request in seconds. Defaults to `30`.
    var timeout: Int { get }
}

public extension AnyRequestManager {
    public func request(_ requestCalls: [AnyRequestCall], completion: RequestCompletion?) {
        self.request(requestCalls, option: .executeAsynchronously(ignoreFailures: true), completion: completion)
    }

    public func request(_ requestCalls: [AnyRequestCall]) {
        self.request(requestCalls, completion: nil)
    }

    public func request(_ requestCall: AnyRequestCall) {
        self.request(requestCall, progressCompletion: nil, completion: nil)
    }

    public func request(_ requestCall: AnyRequestCall, progressCompletion: RequestProgressCompletion?) {
        self.request(requestCall, progressCompletion: progressCompletion, completion: nil)
    }

    public func request(_ requestCall: AnyRequestCall, completion: RequestCompletion?) {
        self.request(requestCall, progressCompletion: nil, completion: completion)
    }
}

public extension RequestManagerConfiguration {

    var headers: [String : String]? {
        return nil
    }

    var timeout: Int {
        return 30
    }
}
