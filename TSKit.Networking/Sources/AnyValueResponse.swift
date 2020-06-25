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

    static var kind: ResponseKind {
        return .json
    }

    var description: String {
        if let descr = self.value as? CustomStringConvertible {
            return "Value: \(descr)"
        } else {
            return "Value: \(String(describing: self.value))"
        }
    }
}
