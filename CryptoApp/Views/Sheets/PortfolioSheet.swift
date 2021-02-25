import SwiftUI

struct PortfolioSheet: View {
  @EnvironmentObject private var stateViewModel: StateViewModel
  @State private var quantity: String = ""
  private var coin: CryptoModel

  @Binding var isPresented: Bool

  init(coin: CryptoModel, isPresented: Binding<Bool>) {
    self._isPresented = isPresented
    self.coin = coin
  }

  var body: some View {
    NavigationView {
      VStack {
        List {
          Section(header: Text("coin")) {
            InformationEntry(icon: "a.circle", label: "Name", value: coin.name)

            InformationEntry(icon: "seal", label: "Symbol", value: coin.symbol)
          }

          Section(header: Text("portfolio")) {
            TextField("amount_owned", text: $quantity)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
          }
        }
            .listStyle(InsetGroupedListStyle())
      }
          .navigationTitle("portfolio")
          .navigationBarTitleDisplayMode(.inline)
          .navigationBarItems(trailing: Button(action: { update() }) {
            Text("update")
          })
    }
      .onAppear {
        quantity = stateViewModel.getIfContains(coin)?.portfolioAmount ?? ""
      }
  }

  private func update() {
    guard let amount = Double(quantity) else {
      return
    }

    stateViewModel.updatePortfolio(coin, amount: amount)
    isPresented = false
  }
}

struct PortfolioSheet_Previews: PreviewProvider {
  static var previews: some View {
    PreviewWrapper()
  }

  struct PreviewWrapper: View {
    @State var isPresented = false
    @State var viewModel = StateViewModel()

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
      ), isPresented: $isPresented)
    }
  }
}

