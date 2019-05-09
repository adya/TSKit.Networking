/// - Since: 01/20/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2018. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation
import TSKit_Core

/// Streamed multipart file.
public struct MultipartStreamFile: AnyMultipartFile {

    public let name: String

    public let stream: InputStream

    public let fileName: String

    public let mimeType: String

    public let length: UInt64

    public var description: String {
        return "\(name) (File: \(fileName)). Type: \(mimeType) (Data size: \(DataSize(bytes: length).shortDescription)."
    }
}
