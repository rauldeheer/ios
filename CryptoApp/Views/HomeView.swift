import SwiftUI

struct HomeView: View {
  @ObservedObject private var viewModel = HomeViewModel()
  @State private var popover = false

  var body: some View {
    Group {
      if viewModel.coins.isEmpty {
        ProgressView()
      } else {
        List(viewModel.coins, id: \.id) { coin in
          Row(coin)
        }
            .id(UUID())
      }
    }
        .listStyle(PlainListStyle())
        .navigationBarItems(leading: leading(), trailing: trailing())
  }

  private func leading() -> some View {
    Button(action: { popover = true }) {
      Text(LocalizedStringKey(viewModel.sorter.slug))
    }
        .sheet(isPresented: $popover) {
          SortSheet(sorters: viewModel.sorters, selected: viewModel.selected, selectNewSorter: viewModel.selectNewSorter, isPresented: $popover)
        }
  }

  private func trailing() -> some View {
    Button(action: { viewModel.sortDesc.toggle() }) {
      Image(systemName: "arrow.down")
          .rotationEffect(Angle.degrees(viewModel.sortDesc ? 180 : 0))
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
