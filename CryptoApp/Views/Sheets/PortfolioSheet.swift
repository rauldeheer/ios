import SwiftUI

struct PortfolioSheet: View {
  @State private var quantity: String = ""
  @Binding private var favoriteViewModel: FavoriteViewModel
  private var coin: CryptoModel

  @Binding var isPresented: Bool

  init(coin: CryptoModel, isPresented: Binding<Bool>, viewModel: Binding<FavoriteViewModel>) {
    self._isPresented = isPresented
    _favoriteViewModel = viewModel
    self.coin = coin

    let favCoin = favoriteViewModel.getIfContains(coin)

    if favCoin != nil {
      self.coin = favCoin!
    }
  }

  var body: some View {
    NavigationView {
      VStack {
        List {
          Section(header: Text("Coin")) {
            InformationEntry(icon: "a.circle", label: "Name", value: coin.name)

            InformationEntry(icon: "seal", label: "Symbol", value: coin.symbol)
          }

          Section(header: Text("Portfolio")) {
            TextField("Amount of owned coins", text: $quantity)
                .multilineTextAlignment(.center)
          }
        }
            .listStyle(InsetGroupedListStyle())
      }
          .navigationTitle("Portfolio")
          .navigationBarTitleDisplayMode(.inline)
          .navigationBarItems(trailing: Button(action: { update() }) {
            Text("Update")
          })
    }
  }

  private func update() {
    guard let amount = Double(quantity) else {
      return
    }

    favoriteViewModel.updatePortfolio(coin, amount: amount)
    isPresented = false
  }
}

struct PortfolioSheet_Previews: PreviewProvider {
  static var previews: some View {
    PreviewWrapper()
  }

  struct PreviewWrapper: View {
    @State var isPresented = false
    @State var viewModel = FavoriteViewModel()

    var body: some View {
      PortfolioSheet(coin: CryptoModel(
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
      ), isPresented: $isPresented, viewModel: $viewModel)
    }
  }
}

