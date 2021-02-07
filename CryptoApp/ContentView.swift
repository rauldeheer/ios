import SwiftUI

struct ContentView: View {
  private var favoriteViewModel = FavoriteViewModel()
  @State private var selection = 0

  var body: some View {
    TabView(selection: $selection) {
      Tab(icon: "house", tag: 0, label: "Home", navigationTitle: "All coins") {
        HomeView()
      }

      Tab(icon: "star", tag: 1, label: "Favorites", navigationTitle: "Favorite coins") {
        FavoritesView()
      }
    }
        .environmentObject(favoriteViewModel)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
