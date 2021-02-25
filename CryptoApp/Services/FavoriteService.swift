import Foundation

final class FavoriteService {
  private let saveKey = "favorites"

  func getCoins() -> [CryptoModel] {
    var coins: [CryptoModel] = []

    if let data = UserDefaults.standard.data(forKey: saveKey) {
      if let decoded = try? JSONDecoder().decode([FavoriteContainer].self, from: data) {
        coins = decoded.map { container in
          CryptoModel(container.coin, ownedAmount: container.ownedAmount)
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

  func update(_ coins: [CryptoModel], coin: CryptoModel) -> [CryptoModel] {
    var updatedCoins = coins.filter({ p in
      p.id != coin.id
    })

    updatedCoins.append(coin)

    return save(updatedCoins)
  }

  func get(_ coin: CryptoModel) -> CryptoModel? {
    getCoins().first(where: { p in
      p.id == coin.id
    })
  }

  private func save(_ coins: [CryptoModel]) -> [CryptoModel] {
    var cryptoContainers: [FavoriteContainer] = []

    coins.forEach { coin in
      cryptoContainers.append(FavoriteContainer(coin: coin.raw, ownedAmount: coin.rawAmount))
    }

    if let encoded = try? JSONEncoder().encode(cryptoContainers) {
      UserDefaults.standard.set(encoded, forKey: saveKey)
    }

    return coins
  }
}
