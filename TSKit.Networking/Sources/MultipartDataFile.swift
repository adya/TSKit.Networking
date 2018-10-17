import Foundation
import TSKit_Core

/// Multipart file with in-memory data.
/// - Version:     3.0
/// - Since:       10/15/2018
/// - Author:      Arkadii Hlushchevskyi
public struct MultipartDataFile: AnyMultipartFile {

    public let name: String

    public let data: Data

    public let fileName: String

    public let mimeType: String

    public var description: String {
        return "\(name) (File: \(fileName)). Type: \(mimeType) (Data size: \(data.size.shortDescription))."
    }
}
