import Foundation

struct UsdContainer: Codable, Hashable {
  let percentChange7d: Double

  enum CodingKeys: String, CodingKey {
    case percentChange7d = "percentChange7D"
  }
}
