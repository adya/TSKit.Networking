/// - Since: 01/20/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2018. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

/// Defines how request parameters should be encoded.
public enum ParameterEncoding {

    /// Encoded as url query.
    case url

    /// Encoded as json and inserted into request body.
    case json

    /// Encoded as parts of multipart-form data.
    case formData
}
