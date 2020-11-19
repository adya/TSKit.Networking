// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

/// A response object containing expected value received from service.
public protocol AnyValueResponse: AnyResponse {

    /// Type of the handled object.
    associatedtype ObjectType

    /// Contains response object.
    var value: ObjectType { get }
}

// MARK: - Response Defaults
public extension AnyValueResponse {

    static var kind: ResponseKind { .json }

    var description: String {
        "Value: \(String(describing: self.value))"
    }
}
