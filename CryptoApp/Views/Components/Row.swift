import SwiftUI

struct Row: View {
  @EnvironmentObject private var favoriteViewModel: FavoriteViewModel

  let coin: CryptoModel

  var body: some View {
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
            .frame(width: 90)
      }
          .background(coin.positiveChange ? Color.green : Color.red)
          .cornerRadius(3.5)

      Button(action: { favoriteViewModel.toggleFavorite(coin) }) {
        Image(systemName: favoriteViewModel.contains(coin) ? "star.fill" : "star")
            .foregroundColor(favoriteViewModel.contains(coin) ? .yellow : .none)
      }
          .buttonStyle(BorderlessButtonStyle())
    }
  }
}

struct Row_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
