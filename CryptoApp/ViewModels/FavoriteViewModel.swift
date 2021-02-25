import Foundation
import Combine

class FavoriteViewModel: ObservableObject {
  private let favoriteService = FavoriteService()

  @Published var coins = [CryptoModel]()

  init() {
    coins = favoriteService.getCoins()
  }

  func toggleFavorite(_ coin: CryptoModel) {
    contains(coin) ? remove(coin) : add(coin)
  }

  func getIfContains(_ coin: CryptoModel) -> CryptoModel? {
    if contains(coin) {
      return favoriteService.get(coin)
    }

    return nil
  }

  func add(_ coin: CryptoModel) -> Void {
    coins = favoriteService.add(coins, coin: coin)
  }

  func remove(_ coin: CryptoModel) -> Void {
    coins = favoriteService.remove(coins, coin: coin)
  }

  func contains(_ coin: CryptoModel) -> Bool {
    favoriteService.contains(coins, id: coin.id)
  }

  func updatePortfolio(_ coin: CryptoModel, amount: Double) -> Void {
    coins = favoriteService.update(coins, coin: CryptoModel(coin.raw, ownedAmount: amount))
  }
}
