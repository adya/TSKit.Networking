// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation
import TSKit_Core

/// Multipart file with in-memory data.
public struct MultipartDataFile: AnyMultipartFile {

    public let name: String

    public let data: Data

    public let fileName: String

    public let mimeType: String

    public var description: String {
        return "\(name) (File: \(fileName)). Type: \(mimeType) (Data size: \(data.size.shortDescription))."
    }
    
    public init(name: String, data: Data, fileName: String, mimeType: String) {
        self.name = name
        self.data = data
        self.fileName = fileName
        self.mimeType = mimeType
    }
}
