import SwiftUI

struct ContentView: View {
  private var stateViewModel = StateViewModel()
  @State private var selection = 0

  var body: some View {
    TabView(selection: $selection) {
      Tab(icon: "bitcoinsign.circle", tag: 0, label: "all_coins", navigationTitle: "all_coins") {
        HomeView()
      }

      Tab(icon: "star", tag: 1, label: "favorite_coins", navigationTitle: "favorite_coins") {
        FavoritesView()
      }
    }
        .environmentObject(stateViewModel)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
        .environment(\.locale, .init(identifier: "nl"))
  }
}
