import SwiftUI

struct FavoritesView: View {
  @EnvironmentObject private var stateViewModel: StateViewModel

  var body: some View {
    if stateViewModel.coins.isEmpty {
      VStack {
        Text("You did not add any coins to your favorites yet, please use the star button on any page to add the coin to this page! ⭐️")
            .multilineTextAlignment(.leading)
            .padding(.horizontal)

        Spacer()
      }
    } else {
      List(stateViewModel.coins, id: \.id) { coin in
        Row(coin, favoriteView: true)
      }
          .id(UUID())
    }
  }
}

struct FavoritesView_Previews: PreviewProvider {
  static var previews: some View {
    FavoritesView()
  }
}
