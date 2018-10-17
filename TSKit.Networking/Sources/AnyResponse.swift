/**
 An empty response object received from service.
 
 - Version:     3.0
 - Since:       10/15/2018
 - Author:      Arkadii Hlushchevskyi
 */
public protocol AnyResponse {
    
    /// Expected type of response to be received from service.
    /// - Note: Defaults to `.json`.
    static var kind: ResponseKind { get }
    
    init?(response: HTTPURLResponse, body: Any?)
    
    /// HTTP response returned by a service.
    var response: HTTPURLResponse { get }
}
