import Foundation

public struct ErrorResponse {

    public let status: Int

    public let description: String?

    public init(response: HTTPURLResponse, data: Data?) {
        status = response.statusCode

        if let data = data,
           let json = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String : Any] {

            if let error = json["error"] as? [String : Any],
                    let messages = error["messages"] as? [String] {
                description = messages.joined(separator: "\n")
            } else {
                description = json["message"] as? String
            }
        } else {
            description = nil
        }
    }
}
