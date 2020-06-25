// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

/// Defines how request parameters should be encoded.
public enum ParameterEncoding {

    /// Encoded as path components.
    /// - Note: The path should contain placeholders matching **parameter** name in format **$paramName**.
    ///         So, for example, paramater named **item_id** should have placeholder **$item_id**.
    @available(*, unavailable, message: "Yet to be implemented")
    case path

    /// Encoded as url query.
    case url

    /// Encoded as json and inserted into request body.
    case json

    /// Encoded as parts of multipart-form data.
    case formData
}
