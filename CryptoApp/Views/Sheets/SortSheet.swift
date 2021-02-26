import SwiftUI

struct SortSheet: View {
  let sorters: [SortModel]
  let selected: (SortModel) -> Bool
  let selectNewSorter: (SortModel) -> Void
  @Binding var isPresented: Bool

  var body: some View {
    NavigationView {
      List(sorters, id: \.slug) { sorter in
        Button(action: { update(sorter) }) {
          HStack {
            Text(LocalizedStringKey(sorter.name))

            Spacer()

            if selected(sorter) {
              Image(systemName: "checkmark")
            }
          }
        }
      }
          .navigationTitle("sort_methods")
          .navigationBarTitleDisplayMode(.inline)
    }
  }

  private func update(_ sorter: SortModel) -> Void {
    selectNewSorter(sorter)
    isPresented = false
  }
}

struct SortSheet_Previews: PreviewProvider {
  private static func selected(_ sorter: SortModel) -> Bool {
    true
  }

  private static func selectNewSorter(_ newSorter: SortModel) -> Void {

  }

  static var previews: some View {
    SortSheet(sorters: [
      SortModel((slug: "Vlm30d", name: "Volume 30 days", param: "volume_30d")),
      SortModel((slug: "Vlm7d", name: "Volume 7 days", param: "volume_7d")),
      SortModel((slug: "Vlm24h", name: "Volume 24 hours", param: "volume_24h")),
      SortModel((slug: "Prc7d", name: "Change 7 days", param: "percent_change_7d")),
      SortModel((slug: "Prc24h", name: "Change 24 hours", param: "percent_change_24h")),
      SortModel((slug: "Prc1h", name: "Change 1 hour", param: "percent_change_1h"))
    ], selected: selected, selectNewSorter: selectNewSorter, isPresented: .constant(false))
  }
}
