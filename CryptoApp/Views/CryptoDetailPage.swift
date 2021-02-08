import SwiftUI

struct CryptoDetailPage: View {
  @EnvironmentObject private var favoriteViewModel: FavoriteViewModel

  var coin: CryptoModel

  var body: some View {
    VStack {
      HStack {
        Text(coin.price)

        Spacer()
      }
      .padding(.horizontal)
      .padding(.vertical, 10)

      Spacer()
    }
        .navigationTitle(coin.name)
        .navigationBarItems(trailing: FavoriteButton(toggle: { favoriteViewModel.toggleFavorite(coin) }, isFavorite: favoriteViewModel.contains(coin)))
  }
}

struct CryptoDetailPage_Previews: PreviewProvider {
  static var previews: some View {
    CryptoDetailPage(coin: CryptoModel(
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
