// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation

public typealias EmptyResponse = Result<Void, NetworkServiceError>

public typealias AnyResponseCompletion = (AnyResponse) -> Void

public typealias ResponseCompletion<ResponseType> = (ResponseType) -> Void where ResponseType: AnyResponse

public typealias AnyErrorCompletion = (AnyNetworkServiceError) -> Void

public typealias ErrorCompletion<ErrorType> = (ErrorType) -> Void where ErrorType: AnyNetworkServiceBodyError

public typealias RequestCompletion = (EmptyResponse) -> Void

public typealias RequestProgressCompletion = (Progress) -> Void
