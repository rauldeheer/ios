import Foundation
import Combine

class FavoriteViewModel: ObservableObject {
  private let favoriteService = FavoriteService()
  private let portfolioService = PortfolioService()

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

  func getPortfolioBy(_ coin: CryptoModel) -> String {
    String(portfolioService.getPortfolioBy(coin: coin))
  }

  func setPortfolioFor(_ coin: CryptoModel, amount: String) -> Void {
    portfolioService.savePortfolioFor(coin: coin, amount)
  }
}
