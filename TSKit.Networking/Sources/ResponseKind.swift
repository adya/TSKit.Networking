// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

/// Defines what kind of data `Response` can handle
public enum ResponseKind {

    /// Response handles JSON.
    case json

    /// Response handles NSData.
    case data

    /// Response handles String.
    case string

    /// TSResponse handles no data.
    case empty
}
