import Foundation
import Combine

final class CryptoService {
  private let apiService = ApiService()

  func getLatestListings(_ sorter: SortModel, desc: Bool) -> AnyPublisher<ResponseContainer<[CryptoContainer]>, Error> {
    apiService.receiveData(apiService.createURL("/cryptocurrency/listings/latest", query: [URLQueryItem(name: "sort", value: sorter.param), URLQueryItem(name: "sort_dir", value: desc ? "desc" : "asc")]))
  }

  func getCoin(_ id: Int) -> AnyPublisher<ResponseContainer<Dictionary<String, CryptoContainer>>, Error> {
    apiService.receiveData(apiService.createURL("/cryptocurrency/quotes/latest", query: [URLQueryItem(name: "id", value: String(id))]))
  }
}
