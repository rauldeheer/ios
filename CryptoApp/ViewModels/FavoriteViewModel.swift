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

  func add(_ coin: CryptoModel) -> Void {
    coins = favoriteService.add(coins, coin: coin)
  }

  func remove(_ coin: CryptoModel) -> Void {
    coins = favoriteService.remove(coins, coin: coin)
  }

  func contains(_ coin: CryptoModel) -> Bool {
    favoriteService.contains(coins, id: coin.id)
  }
}
