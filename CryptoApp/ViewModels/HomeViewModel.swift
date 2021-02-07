import Combine
import Foundation

class HomeViewModel: ObservableObject {
  private let cryptoService = CryptoService()

  @Published var coins = [CryptoModel]()
  var cancellable: AnyCancellable?

  init() {
    coins = []

    cancellable = cryptoService.getLatestListings().sink(receiveCompletion: { completion in
      print("home \(completion)")
    }, receiveValue: { cryptoContainers in
      self.coins = cryptoContainers.data.map { cryptoContainer in
        CryptoModel(cryptoContainer)
      }
    })
  }
}
