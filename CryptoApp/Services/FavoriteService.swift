import Foundation

final class FavoriteService {
  private let saveKey = "favorites"

  func getCoins() -> [CryptoModel] {
    var coins: [CryptoModel] = []

    if let data = UserDefaults.standard.data(forKey: saveKey) {
      if let decoded = try? JSONDecoder().decode([CryptoContainer].self, from: data) {
        coins = decoded.map { coin in
          CryptoModel(coin)
        }
      }
    }

    return coins
  }

  func contains(_ coins: [CryptoModel], id: Int) -> Bool {
    coins.contains(where: { p in
      p.id == id
    })
  }

  func add(_ coins: [CryptoModel], coin: CryptoModel) -> [CryptoModel] {
    save(coins + [coin])
  }

  func remove(_ coins: [CryptoModel], coin: CryptoModel) -> [CryptoModel] {
    save(coins.filter({ p in
      p.id != coin.id
    }))
  }

  private func save(_ coins: [CryptoModel]) -> [CryptoModel] {
    var cryptoContainers: [CryptoContainer] = []

    coins.forEach { coin in
      cryptoContainers.append(coin.raw)
    }

    if let encoded = try? JSONEncoder().encode(cryptoContainers) {
      UserDefaults.standard.set(encoded, forKey: saveKey)
    }

    return coins
  }
}
