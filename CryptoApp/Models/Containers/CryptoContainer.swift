import Foundation

struct CryptoContainer: Codable, Hashable {
  let id: Int
  let name: String
  let symbol: String
  let circulatingSupply: Double?
  let maxSupply: Double?
  let marketPairs: Int
  let rank: Int
  let quote: QuoteContainer

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case symbol
    case circulatingSupply
    case maxSupply
    case marketPairs = "numMarketPairs"
    case rank = "cmcRank"
    case quote
  }
}
