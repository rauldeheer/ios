import SwiftUI

struct FavoritesView: View {
  @EnvironmentObject private var stateViewModel: StateViewModel

  var body: some View {
    if stateViewModel.coins.isEmpty {
      VStack {
        Text("no_favorites")
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
