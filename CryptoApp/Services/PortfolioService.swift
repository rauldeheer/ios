import Foundation

final class PortfolioService {
  func getPortfolioBy(coin: CryptoModel) -> Double {
    if let data = UserDefaults.standard.data(forKey: coin.symbol) {
      if let decoded = try? JSONDecoder().decode(PortfolioContainer.self, from: data) {
        return decoded.amount
      }
    }

    return 0
  }

  func savePortfolioFor(coin: CryptoModel, _ amount: String) -> Void {
    guard let convertedAmount = Double(amount) else {
      return
    }

    let container = PortfolioContainer(amount: convertedAmount)

    if let encoded = try? JSONEncoder().encode(container) {
      UserDefaults.standard.set(encoded, forKey: coin.symbol)
    }
  }
}
