import SwiftUI

struct Tab<Content: View>: View {
  let icon: String
  let tag: Int
  let label: String
  let navigationTitle: String
  let content: () -> Content

  var body: some View {
    NavigationView {
      content()
          .navigationTitle(navigationTitle)
    }
        .tabItem {
          VStack {
            Image(systemName: icon)
                .font(.system(size: 22))

            Text(label)
          }
        }
        .tag(tag)
  }
}

struct Tab_Previews: PreviewProvider {
  static var previews: some View {
    TabView {
      Tab(icon: "house", tag: 0, label: "Home", navigationTitle: "Home") {
        VStack {
          Text("Homepage")

          Spacer()
        }
      }
    }
  }
}
