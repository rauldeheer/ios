import Foundation

struct CryptoModel {
  private let coin: CryptoContainer

  init(_ coin: CryptoContainer) {
    self.coin = coin
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
    let amount = Int(floor(coin.quote.USD.price * 100)) % 100
    return String(format: "%.\(amount > 6 ? 6 : amount)f", coin.quote.USD.price)
  }

  var change: String {
    String(format: "%.2f", coin.quote.USD.percentChange7d)
  }

  var positiveChange: Bool {
    coin.quote.USD.percentChange7d >= 0
  }
}
