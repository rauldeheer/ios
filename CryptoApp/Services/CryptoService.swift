import Foundation
import Combine

final class CryptoService {
  private let apiService = ApiService()

  func getLatestListings() -> AnyPublisher<ResponseContainer<[CryptoContainer]>, Error> {
    apiService.receiveData(apiService.createURL("/cryptocurrency/listings/latest", query: [URLQueryItem(name: "sort", value: "volume_7d")]))
  }
}
