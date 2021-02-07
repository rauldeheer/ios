import Foundation

struct ResponseModel<T: Codable>: Codable {
  let data: [T]
}
