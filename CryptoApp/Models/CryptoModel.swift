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

  var change: String {
    String(format: "%.2f", coin.quote.USD.percentChange7d)
  }

  var positiveChange: Bool {
    coin.quote.USD.percentChange7d >= 0
  }
}
