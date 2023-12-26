import Foundation

enum NetworkError: Error {
    case nilResponse
    case badUrl
    case encoding
    case response(Int)
}

