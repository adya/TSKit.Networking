/** 
 Represents result of the request with associated responded object.
 
 - Requires:    iOS  [2.0; 8.0)
 - Requires:    Swift 2+
 - Version:     2.1
 - Since:       10/30/2016
 - Author:      AdYa
 */
public enum ResponseResult <T: Any> {
    
    /// Response was successful and valid.
    /// - Parameter response: a response object.
    case success(response : T)
    
    /// Request failed with an error.
    /// - Parameter error: Occurred error.
    case failure(error : RequestError)
}

/**
 Represents result of the request without any object.

- Requires:    iOS  [2.0; 8.0)
- Requires:    Swift 2+
- Version:     2.1
- Since:       10/30/2016
- Author:      AdYa
*/
public enum EmptyResult {
    
    /// Response was successful and valid.
    case success
    
    /// Request failed with an error.
    case failure(error : RequestError)
}

// MARK: - Conversion
public extension EmptyResult {
    public init(responseResult : AnyResponseResult) {
        switch responseResult {
        case .success: self = .success
        case .failure(let error): self = .failure(error: error)
        }
    }
}

public typealias AnyResponseResult = ResponseResult<AnyResponse>

public typealias AnyResponseResultCompletion = (AnyResponseResult) -> Void

public typealias ResponseResultCompletion<ResponseType> = (ResponseResult<ResponseType>) -> Void where ResponseType: AnyResponse

