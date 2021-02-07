import Foundation

struct ResponseContainer<T: Codable>: Codable {
  let data: T
}
