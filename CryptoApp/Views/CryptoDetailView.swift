import SwiftUI

struct CryptoDetailView: View {
  @EnvironmentObject private var favoriteViewModel: FavoriteViewModel
  @ObservedObject private var viewModel = DetailViewModel()
  @State private var portfolioOpen = false

  var coin: CryptoModel
  var favoriteView: Bool

  init(_ coin: CryptoModel, favoriteView: Bool = false) {
    self.coin = coin
    self.favoriteView = favoriteView
  }

  var body: some View {
    Group {
      if !favoriteView || viewModel.coin != nil {
        let currentCoin: CryptoModel = favoriteView && viewModel.coin != nil ? viewModel.coin! : coin

        List {
          InformationEntry(icon: "chevron.up.chevron.down", label: "Ranking", value: currentCoin.rank)

          InformationEntry(icon: "seal", label: "Symbol", value: currentCoin.symbol)

          InformationEntry(icon: "dollarsign.circle", label: "Price", value: currentCoin.price)

          InformationEntry(icon: "arrow.triangle.2.circlepath", label: "Circulating", value: currentCoin.totalSupply)

          InformationEntry(icon: "multiply", label: "Max", value: currentCoin.maxSupply)

          InformationEntry(icon: "number", label: "Pairs", value: currentCoin.marketPairs)

          Section(header: Text("Portfolio")) {
            InformationEntry(icon: "number", label: "Quantity", value: currentCoin.marketPairs)

            InformationEntry(icon: "line.diagonal.arrow", label: "Value", value: currentCoin.marketPairs)

            HStack {
              Spacer()

              Button(action: { portfolioOpen.toggle() }) {
                Text("Update portfolio")
              }

              Spacer()
            }
             .sheet(isPresented: $portfolioOpen, onDismiss: { portfolioOpen = false }) {
               PortfolioSheet(coin: currentCoin)
             }
          }
        }
            .listStyle(InsetGroupedListStyle())
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
            circulatingSupply: 200,
            maxSupply: 230,
            marketPairs: 200,
            rank: 1,
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
