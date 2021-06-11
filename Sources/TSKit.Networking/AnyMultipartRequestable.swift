// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Networking/blob/master/LICENSE.md

import Foundation
import TSKit_Core

/// Defines multipart request properties required to perform a request call.
public protocol AnyMultipartRequestable: AnyRequestable {

    /// Multipart files to be appended to request form data.
    /// - Seealso: `MultipartDataFile`, `MultipartURLFile`, `MultipartStreamFile`.
    /// - Note: Default = nil.
    var files: [AnyMultipartFile]? { get }

    /// Encoding used when appending parameters to multipart form data.
    var parametersDataEncoding: String.Encoding { get }
}

// MARK: Defaults
public extension AnyMultipartRequestable {

    var files: [AnyMultipartFile]? {
        nil
    }

    var parametersDataEncoding: String.Encoding {
        .utf8
    }

    var encoding: ParameterEncoding {
        .formData
    }

    var description: String {
        var descr = "\(self.method) '"
        if let baseUrl = self.host {
            descr += "\(baseUrl)/"
        }
        descr += "\(self.path)'"
        if let headers = self.headers {
            descr += "\nHeaders:\n\(headers)"
        }
        if let params = self.parameters {
            descr += "\nParameters:\n\(params)"
        }
        if let files = self.files {
            descr += "\nFiles:\n"
            files.forEach {
                descr += "\($0.name) of type '\($0.mimeType)' (\($0))"
            }
        }
        return descr
    }
}
