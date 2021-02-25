import SwiftUI

struct Row: View {
  @EnvironmentObject private var stateViewModel: StateViewModel

  let coin: CryptoModel
  let favoriteView: Bool

  init(_ coin: CryptoModel, favoriteView: Bool = false) {
    self.coin = coin
    self.favoriteView = favoriteView
  }

  var body: some View {
    NavigationLink(destination: CryptoDetailView(coin, favoriteView: favoriteView)) {
      HStack {
        VStack(alignment: .leading) {
          Text(coin.name)
              .lineLimit(1)

          Text(coin.symbol)
              .fontWeight(.light)
              .font(.caption)
        }

        if !favoriteView {
          GeometryReader { geometry in
            HStack {
              Spacer()

              VStack {
                Spacer()

                ZStack {
                  Text(coin.change)
                      .foregroundColor(.white)
                      .font(.system(size: min(geometry.size.height, geometry.size.width) * 0.4))
                      .fontWeight(.semibold)
                      .frame(width: 90)
                }
                    .background(coin.positiveChange ? Color.green : Color.red)
                    .cornerRadius(3.5)

                Spacer()
              }
            }
          }
        } else {
          Spacer()
        }

        FavoriteButton(toggle: { stateViewModel.toggleFavorite(coin) }, isFavorite: stateViewModel.contains(coin))
      }
    }
  }
}

struct Row_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
