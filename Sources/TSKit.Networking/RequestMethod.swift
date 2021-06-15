// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

/// Supported HTTP Methods.
public enum RequestMethod {

    case get

    case head

    case post

    case put

    case patch

    case delete
    
    case trace
    
    case options
    
    /// - GET
    /// - HEAD
    /// - OPTIONS
    /// - TRACE
    /// - PUT
    /// - DELETE
    ///
    /// See [Idempotency definition](https://datatracker.ietf.org/doc/html/rfc7231#section-4.2.2).
    public static var allIdempotent: Set<RequestMethod> {
        allSafe.union([.put, .delete])
    }
    
    /// - GET
    /// - HEAD
    /// - OPTIONS
    /// - TRACE
    ///
    /// See [Safety definition](https://datatracker.ietf.org/doc/html/rfc7231#section-4.2.1).
    public static var allSafe: Set<RequestMethod> {
        [.get, .head, .options, .trace]
    }
    
    public static var all: Set<RequestMethod> {
        allIdempotent.union(allNonIdempotent)
    }
    
    /// - POST
    /// - PATCH
    /// See [Idempotency definition](https://datatracker.ietf.org/doc/html/rfc7231#section-4.2.2).
    public static var allNonIdempotent: Set<RequestMethod> {
        [.post, .patch]
    }
}

public extension Set where Element == RequestMethod {
    
    /// - GET
    /// - HEAD
    /// - OPTIONS
    /// - TRACE
    /// - PUT
    /// - DELETE
    ///
    /// See [Idempotency definition](https://datatracker.ietf.org/doc/html/rfc7231#section-4.2.2).
    static var allIdempotent: Set<RequestMethod> {
        RequestMethod.allIdempotent
    }
    
    /// - GET
    /// - HEAD
    /// - OPTIONS
    /// - TRACE
    ///
    /// See [Safety definition](https://datatracker.ietf.org/doc/html/rfc7231#section-4.2.1).
    static var allSafe: Set<RequestMethod> {
        RequestMethod.allSafe
    }
    
    static var all: Set<RequestMethod> {
        RequestMethod.all
    }
    
    /// - POST
    /// - PATCH
    /// See [Idempotency definition](https://datatracker.ietf.org/doc/html/rfc7231#section-4.2.2).
    static var nonIdempotent: Set<RequestMethod> {
        RequestMethod.allNonIdempotent
    }
}
