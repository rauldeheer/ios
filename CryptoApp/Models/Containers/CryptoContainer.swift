import Foundation

struct CryptoContainer: Codable, Hashable {
  let id: Int
  let name: String
  let symbol: String
  let quote: QuoteContainer
}
