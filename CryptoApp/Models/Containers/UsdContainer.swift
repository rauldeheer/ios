import Foundation

struct UsdContainer: Codable, Hashable {
  let percentChange7d: Double
  let price: Double

  enum CodingKeys: String, CodingKey {
    case percentChange7d = "percentChange7D"
    case price
  }
}
