import SwiftUI

struct CryptoDetailView: View {
  @EnvironmentObject private var stateViewModel: StateViewModel
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
      if (!favoriteView || viewModel.coin != nil) || (favoriteView && viewModel.coin == nil) {
        let currentCoin: CryptoModel = favoriteView && viewModel.coin != nil ? viewModel.coin! : coin

        List {
          InformationEntry(icon: "chevron.up.chevron.down", label: "ranking", value: currentCoin.rank)

          InformationEntry(icon: "seal", label: "symbol", value: currentCoin.symbol)

          InformationEntry(icon: "dollarsign.circle", label: "price", value: currentCoin.price)

          InformationEntry(icon: "arrow.triangle.2.circlepath", label: "circulating", value: currentCoin.totalSupply)

          InformationEntry(icon: "multiply", label: "max", value: currentCoin.maxSupply)

          InformationEntry(icon: "number", label: "pairs", value: currentCoin.marketPairs)

          if stateViewModel.contains(coin) {
            Section(header: Text("portfolio")) {
              InformationEntry(icon: "number", label: "quantity", value: stateViewModel.getIfContains(coin)?.portfolioAmount ?? "")

              InformationEntry(icon: "line.diagonal.arrow", label: "value", value: stateViewModel.getIfContains(coin)?.totalValue ?? "")

              HStack {
                Spacer()

                Button(action: { portfolioOpen.toggle() }) {
                  Text("update_portfolio")
                }

                Spacer()
              }
                  .sheet(isPresented: $portfolioOpen, onDismiss: { portfolioOpen = false }) {
                    PortfolioSheet(coin: currentCoin, isPresented: $portfolioOpen)
                  }
            }
          }
        }
            .listStyle(InsetGroupedListStyle())
      } else {
        ProgressView()
      }
    }
        .navigationTitle(coin.name)
        .navigationBarItems(trailing: FavoriteButton(toggle: { stateViewModel.toggleFavorite(coin) }, isFavorite: stateViewModel.contains(coin)))
        .onAppear {
          if favoriteView && viewModel.coin == nil {
            viewModel.load(coin: coin.id)
          }
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
