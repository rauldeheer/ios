import Combine
import Foundation

class HomeViewModel: ObservableObject {
  private let cryptoService = CryptoService()

  @Published var sortDesc = true {
    didSet {
      getCoins()
    }
  }

  @Published var sorter: SortModel = SortModel((slug: "vlm30d", name: "volume_30_days", param: "volume_30d")) {
    didSet {
      getCoins()
    }
  }

  @Published var coins = [CryptoModel]()
  @Published var sorters = [SortModel](
      [
        SortModel((slug: "vlm30d", name: "volume_30_days", param: "volume_30d")),
        SortModel((slug: "vlm7d", name: "volume_7_days", param: "volume_7d")),
        SortModel((slug: "vlm24h", name: "volume_24_hours", param: "volume_24h")),
        SortModel((slug: "prc7d", name: "change_7_days", param: "percent_change_7d")),
        SortModel((slug: "prc24h", name: "change_24_hours", param: "percent_change_24h")),
        SortModel((slug: "prc1h", name: "change_1_hour", param: "percent_change_1h"))
      ]
  )

  var cancellable: AnyCancellable?

  init() {
    getCoins()
  }

  func selected(_ sorter: SortModel) -> Bool {
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
