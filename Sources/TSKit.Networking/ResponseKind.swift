// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

/// Defines what kind of data `Response` can handle
public enum ResponseKind {

    /// Response handles JSON.
    case json

    /// Response handles `Data`.
    case data

    /// Response handles `String`.
    case string

    /// Response ignores any data.
    case empty
    
    /// Response handles data downloaded as file.
    /// `value` for such response will be a url for temporary file stored according to `configuration.sessionTemporaryFilesDirectory`.
    case file
}
