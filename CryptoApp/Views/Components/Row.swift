import SwiftUI

struct Row: View {
  @EnvironmentObject private var favoriteViewModel: FavoriteViewModel

  let coin: CryptoModel

  var body: some View {
    NavigationLink(destination: CryptoDetailView(coin: coin)) {
      HStack {
        VStack(alignment: .leading) {
          Text(coin.name)

          Text(coin.symbol)
              .fontWeight(.light)
              .font(.caption)
        }

        Spacer()

        ZStack {
          Text((coin.positiveChange ? "+" : "") + coin.change + "%")
              .foregroundColor(.white)
              .fontWeight(.semibold)
              .frame(width: 90)
        }
            .background(coin.positiveChange ? Color.green : Color.red)
            .cornerRadius(3.5)

        FavoriteButton(toggle: { favoriteViewModel.toggleFavorite(coin) }, isFavorite: favoriteViewModel.contains(coin))
      }
    }
  }
}

struct Row_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
