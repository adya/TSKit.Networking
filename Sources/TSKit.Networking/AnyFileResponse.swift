// - Since: 10/22/2020
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation

/// A response object containing path for file downloaded from service.
public protocol AnyFileResponse: AnyResponse {

    /// Path to downloaded temporary file.
    var file: URL { get }
}

// MARK: - Response Defaults
public extension AnyFileResponse {

    static var kind: ResponseKind { .file }

    var description: String {
        "Downloaded file at \(file)"
    }
}
