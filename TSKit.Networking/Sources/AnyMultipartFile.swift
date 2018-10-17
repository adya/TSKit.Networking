/**
 Multipart file representation to be appended to multipart request.
 
 - Version:     3.0
 - Since:       10/15/2018
 - Author:      Arkadii Hlushchevskyi
 */
public protocol AnyMultipartFile: CustomStringConvertible {

    /// Parameter name of the appended file data.
    var name: String { get }

    /// Name of the file appended to request.
    var fileName: String { get }

    /// Mime type of the appended file.
    var mimeType: String { get }
}
