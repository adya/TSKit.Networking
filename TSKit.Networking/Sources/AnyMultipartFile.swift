// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

/// Multipart file representation to be appended to multipart request.
public protocol AnyMultipartFile: CustomStringConvertible {

    /// Parameter name of the appended file data.
    var name: String { get }

    /// Name of the file appended to request.
    var fileName: String { get }

    /// Mime type of the appended file.
    var mimeType: String { get }
}
