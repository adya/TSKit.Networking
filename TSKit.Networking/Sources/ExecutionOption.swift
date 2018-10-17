/**
 Defines advanced behavior of `AnyNetworkService` when dealing with multiple requests.
 
- Version:     3.0
- Since:       10/15/2018
- Author:      Arkadii Hlushchevskyi
*/
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
