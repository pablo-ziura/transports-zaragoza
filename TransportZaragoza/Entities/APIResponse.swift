import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let result: [T]
}
