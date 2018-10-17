import Foundation

/// Multipart file stored in file system.
/// - Version:     3.0
/// - Since:       10/15/2018
/// - Author:      Arkadii Hlushchevskyi
public struct MultipartURLFile: AnyMultipartFile {

    public let name: String

    public let url: URL

    public let fileName: String

    public let mimeType: String

    public var description: String {
        return "\(name) (File: \(fileName)). Type: \(mimeType) (Located at: \(url.path))."
    }
}
