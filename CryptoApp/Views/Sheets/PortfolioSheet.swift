import SwiftUI

struct PortfolioSheet: View {
  @EnvironmentObject private var favoriteViewModel: FavoriteViewModel
  @State private var quantity: String

  private let coin: CryptoModel
  @Binding var isPresented: Bool

  init(coin: CryptoModel, isPresented: Binding<Bool>) {
    self.coin = coin
    self.isPresented = isPresented
    quantity = favoriteViewModel.getPortfolioBy(coin)
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
    favoriteViewModel.setPortfolioFor(coin, amount: quantity)
    isPresented = false
  }
}

struct PortfolioSheet_Previews: PreviewProvider {
  static var previews: some View {
    PreviewWrapper()
  }

  struct PreviewWrapper: View {
    @State var isPresented = false

    var body: some View {
      PortfolioSheet()
    }
  }
}

