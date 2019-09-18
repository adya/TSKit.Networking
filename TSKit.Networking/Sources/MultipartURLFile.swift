/// - Since: 01/20/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2018. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation

/// Multipart file stored in file system.
public struct MultipartURLFile: AnyMultipartFile {

    public let name: String

    public let url: URL

    public let fileName: String

    public let mimeType: String

    public var description: String {
        return "\(name) (File: \(fileName)). Type: \(mimeType) (Located at: \(url.path))."
    }
    
    public init(name: String, url: URL, fileName: String, mimeType: String) {
        self.name = name
        self.url = url
        self.fileName = fileName
        self.mimeType = mimeType
    }
}
