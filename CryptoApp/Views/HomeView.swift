import SwiftUI

struct HomeView: View {
  @ObservedObject private var viewModel = HomeViewModel()

  var body: some View {
    List {
      ForEach(viewModel.coins, id: \.id) { coin in
        Row(coin: coin)
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
