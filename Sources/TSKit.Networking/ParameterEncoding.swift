// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
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

public extension ParameterEncoding {
    
    struct Options {
        
        /// Strategy that is used to encode `Bool` values.
        public enum BoolEncoding {
            
            /// Encode `Bool` parameters as string literals:
            /// - `false`
            /// - `true`.
            case literal
            
            /// Encode `Bool` parameters as numbers:
            /// - `0` represents `false`
            /// - `1` represents `true`.
            case numeric
        }
        
        /// Flag indicating whether array parameters should be encoded using brackets-style naming.
        /// For example:
        /// `let parameters = ["param": [10, 20]]`
        /// with brackets will be encoded as `param[]=10&param[]=20`.
        /// Otherwise it will be as `param=10&param=20`.
        /// - Note: Defaults to `true`.
        public var useBracketsForArrays: Bool
        
        /// Strategy that is used to encode `Bool` values.
        /// - Note: Defaults to `.literal`.
        public var boolEncoding: BoolEncoding
        
        public init(useBracketsForArrays: Bool = true,
                    boolEncoding: BoolEncoding = .literal) {
            self.useBracketsForArrays = useBracketsForArrays
            self.boolEncoding = boolEncoding
        }
    }
}
