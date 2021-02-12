import Foundation
import Combine

final class CryptoService {
  private let apiService = ApiService()

  func getLatestListings(sorter: SortModel, sortDesc: Bool) -> AnyPublisher<ResponseContainer<[CryptoContainer]>, Error> {
    apiService.receiveData(apiService.createURL("/cryptocurrency/listings/latest", query: [URLQueryItem(name: "sort", value: sorter.param), URLQueryItem(name: "sort_dir", value: sortDesc ? "desc" : "asc")]))
  }
}
