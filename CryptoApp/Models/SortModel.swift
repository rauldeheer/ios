import Foundation
import Combine

struct SortModel {
  private var sorter: (slug: String, name: String, param: String)

  init(_ sorter: (slug: String, name: String, param: String)) {
    self.sorter = sorter
  }

  var slug: String {
    sorter.slug
  }

  var name: String {
    sorter.name
  }

  var param: String {
    sorter.param
  }
}
