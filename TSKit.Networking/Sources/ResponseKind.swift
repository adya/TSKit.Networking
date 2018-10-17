/**
 Defines what kind of data `Response` can handle
 
 - Version:     3.0
 - Since:       10/15/2018
 - Author:      Arkadii Hlushchevskyi
 */
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
