import Foundation

/**
 Represents result of the request with associated responded object.
 
 - Version:     3.0
 - Since:       10/15/2018
 - Author:      Arkadii Hlushchevskyi
 */
public enum ResponseResult <T: Any> {
    
    /// Response was successful and valid.
    /// - Parameter response: A response object.
    case success(response : T)
    
    /// Request failed with an error.
    /// - Parameter error: Occurred error.
    case failure(error : Error)
}

public typealias EmptyResponseResult = ResponseResult<Void>

public typealias AnyResponseResult = ResponseResult<AnyResponse>

public typealias AnyResponseResultCompletion = (AnyResponseResult) -> Void

public typealias ResponseResultCompletion<ResponseType> = (ResponseResult<ResponseType>) -> Void where ResponseType: AnyResponse

public typealias RequestCompletion = (EmptyResponseResult) -> Void

public typealias RequestProgressCompletion = (Progress) -> Void
