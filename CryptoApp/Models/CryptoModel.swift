import Foundation

struct CryptoModel {
  private let coin: CryptoContainer
  private let ownedAmount: Double

  init(_ coin: CryptoContainer, ownedAmount: Double = 0) {
    self.coin = coin
    self.ownedAmount = ownedAmount
  }

  var id: Int {
    coin.id
  }

  var name: String {
    coin.name
  }

  var symbol: String {
    coin.symbol
  }

  var raw: CryptoContainer {
    coin
  }

  var price: String {
    let priceSplit = String(coin.quote.USD.price).split(separator: ".")
    return String(format: "$%.\(priceSplit[0].prefix(1) != "0" ? 2 : 6)f", coin.quote.USD.price)
  }

  var change: String {
    let change = String(format: "%.2f", coin.quote.USD.percentChange7d)
    return "\(positiveChange ? "+" : "")\(change)%"
  }

  var positiveChange: Bool {
    coin.quote.USD.percentChange7d >= 0
  }

  var marketPairs: String {
    String(coin.marketPairs)
  }

  var totalSupply: String {
    guard let supply = coin.circulatingSupply else {
      return ""
    }

    return String(supply)
  }

  var maxSupply: String {
    guard let supply = coin.maxSupply else {
      return ""
    }

    return String(supply)
  }

  var rank: String {
    String(coin.rank)
  }

  var portfolioAmount: String {
    String(ownedAmount)
  }

  var rawAmount: Double {
    ownedAmount
  }
}
