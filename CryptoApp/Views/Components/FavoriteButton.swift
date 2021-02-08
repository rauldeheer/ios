import SwiftUI

struct FavoriteButton: View {
  var toggle: () -> Void
  var isFavorite: Bool

  var body: some View {
    Button(action: toggle) {
      Image(systemName: isFavorite ? "star.fill" : "star")
          .foregroundColor(isFavorite ? .yellow : .none)
    }
        .buttonStyle(BorderlessButtonStyle())
  }
}

struct FavoriteButton_Previews: PreviewProvider {
  static var previews: some View {
    FavoriteButton(toggle: { }, isFavorite: false)
  }
}
