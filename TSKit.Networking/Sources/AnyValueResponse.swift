/**
 A response object containing expected value received from service.
 
 - Version:     3.0
 - Since:       10/15/2018
 - Author:      Arkadii Hlushchevskyi
 */
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
