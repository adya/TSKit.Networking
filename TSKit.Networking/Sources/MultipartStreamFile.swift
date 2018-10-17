import Foundation
import TSKit_Core

/// Streamed multipart file.
/// - Version:     3.0
/// - Since:       10/15/2018
/// - Author:      Arkadii Hlushchevskyi
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
