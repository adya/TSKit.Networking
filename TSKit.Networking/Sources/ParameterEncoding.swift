/** 
 Defines how request parameters should be encoded.
 
 - Version:     3.0
 - Since:       10/15/2018
 - Author:      Arkadii Hlushchevskyi
 */
public enum ParameterEncoding {

    /// Encoded as url query.
    case url

    /// Encoded as json and inserted into request body.
    case json

    /// Encoded as parts of multipart-form data.
    case formData
}
