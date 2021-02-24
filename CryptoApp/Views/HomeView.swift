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
      }
    }
        .navigationBarItems(leading: leading(), trailing: trailing())
  }

  private func leading() -> some View {
    Popover(showPopover: $popover, popoverSize: CGSize(width: 175, height: viewModel.sorters.count * 40), content: {
      Button(action: { popover.toggle() }) {
        Text(viewModel.sorter.slug)
      }
    }) {
      ForEach(viewModel.sorters, id: \.slug) { sorter in
        GeometryReader { geometry in
          Button(action: {
            viewModel.selectNewSorter(sorter)
            popover.toggle()
          }) {
            VStack {
              Spacer()

              Text(sorter.name)

              Spacer()
            }
                .padding(.horizontal, 7)
          }
        }
      }
    }
  }

  private func trailing() -> some View {
    var animation: Animation {
      .easeOut
    }

    return Button(action: { viewModel.sortDesc.toggle() }) {
      Image(systemName: "arrow.down")
          .rotationEffect(Angle.degrees(viewModel.sortDesc ? 180 : 0))
          .animation(animation)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
