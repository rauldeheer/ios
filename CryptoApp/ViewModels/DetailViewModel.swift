import Foundation
import Combine

class DetailViewModel: ObservableObject {
  private let cryptoService = CryptoService()

  @Published var coin: CryptoModel? = nil

  var cancellable: AnyCancellable?

  func load(coin: Int) {
    cancellable = cryptoService.getCoin(coin).sink(receiveCompletion: { completion in
      print("detail \(completion)")
    }, receiveValue: { coin in
      guard let container = coin.data.first else {
        return
      }

      self.coin = CryptoModel(container.value)
    })
  }
}
