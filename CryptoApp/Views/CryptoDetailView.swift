import SwiftUI

struct CryptoDetailView: View {
  @EnvironmentObject private var favoriteViewModel: FavoriteViewModel
  @ObservedObject private var viewModel = DetailViewModel()

  var coin: CryptoModel
  var favoriteView: Bool

  init(_ coin: CryptoModel, favoriteView: Bool = false) {
    self.coin = coin
    self.favoriteView = favoriteView
  }

  var body: some View {
    Group {
      if !favoriteView || viewModel.coin != nil {
        let currentCoin: CryptoModel = favoriteView ? viewModel.coin! : coin

        VStack {
          HStack {
            Text(currentCoin.price)

            Spacer()
          }
              .padding(.horizontal)
              .padding(.vertical, 10)

          Spacer()
        }
      } else {
        ProgressView()
      }
    }
        .navigationTitle(coin.name)
        .navigationBarItems(trailing: FavoriteButton(toggle: { favoriteViewModel.toggleFavorite(coin) }, isFavorite: favoriteViewModel.contains(coin)))
        .onAppear(perform: { getDetails() })
  }

  private func getDetails() {
    if favoriteView {
      viewModel.load(coin: coin.id)
    }
  }
}

struct CryptoDetailView_Previews: PreviewProvider {
  static var previews: some View {
    CryptoDetailView(CryptoModel(
        CryptoContainer(
            id: 1,
            name: "Bitcoin",
            symbol: "BTC",
            quote: QuoteContainer(
                USD: UsdContainer(
                    percentChange7d: 15.0,
                    price: 200.0
                )
            )
        )
    ))
  }
}
