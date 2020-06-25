// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

/// Defines advanced behavior of `AnyNetworkService` when dealing with multiple requests.
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
