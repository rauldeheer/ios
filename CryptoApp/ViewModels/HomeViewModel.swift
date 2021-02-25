import Combine
import Foundation

class HomeViewModel: ObservableObject {
  private let cryptoService = CryptoService()

  @Published var sortDesc = true {
    didSet {
      getCoins()
    }
  }

  @Published var sorter: SortModel = SortModel((slug: "Vlm30d", name: "Volume 30 days", param: "volume_30d")) {
    didSet {
      getCoins()
    }
  }

  @Published var coins = [CryptoModel]()
  @Published var sorters = [SortModel](
      [
        SortModel((slug: "Vlm30d", name: "Volume 30 days", param: "volume_30d")),
        SortModel((slug: "Vlm7d", name: "Volume 7 days", param: "volume_7d")),
        SortModel((slug: "Vlm24h", name: "Volume 24 hours", param: "volume_24h")),
        SortModel((slug: "Prc7d", name: "Change 7 days", param: "percent_change_7d")),
        SortModel((slug: "Prc24h", name: "Change 24 hours", param: "percent_change_24h")),
        SortModel((slug: "Prc1h", name: "Change 1 hour", param: "percent_change_1h"))
      ]
  )

  var cancellable: AnyCancellable?

  init() {
    getCoins()
  }

  func selected(sorter: SortModel) -> Bool {
    sorter.slug == self.sorter.slug
  }

  func selectNewSorter(_ newSorter: SortModel) -> Void {
    sorter = newSorter
  }

  private func getCoins() -> Void {
    coins = []

    cancellable = cryptoService.getLatestListings(sorter, desc: sortDesc).sink(receiveCompletion: { completion in
    }, receiveValue: { cryptoContainers in
      self.coins = cryptoContainers.data.map { cryptoContainer in
        CryptoModel(cryptoContainer)
      }
    })
  }
}
