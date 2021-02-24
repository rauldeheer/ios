import SwiftUI

struct InformationEntry: View {
  let icon: String
  let label: String
  let value: String

  var body: some View {
    HStack {
      Image(systemName: icon)
          .frame(width: 20, height: 20)

      Text(label)

      Spacer()

      Text(value)
    }
  }
}

struct InformationEntry_Previews: PreviewProvider {
  static var previews: some View {
    InformationEntry(icon: "number", label: "Price", value: "20")
  }
}
