import SwiftUI

struct PortfolioSheet: View {
  @State private var quantity = ""

  let coin: CryptoModel

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
          .navigationBarItems(trailing: Button(action: { print("done") }) {
            Text("Update")
          })
    }
  }
}

struct PortfolioSheet_Previews: PreviewProvider {
  static var previews: some View {
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
    ))
  }
}

