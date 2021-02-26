import Foundation
import Combine

final class ApiService {
  func receiveData<T: Decodable>(_ url: URL, method: String = "GET") -> AnyPublisher<T, Error> {
    guard let infoDictionary = Bundle.main.infoDictionary else {
      fatalError("Info dictionary not available")
    }

    guard let apiKey = infoDictionary["API_KEY"] as? String else {
      fatalError("Please specify a API key")
    }

    var request = URLRequest(url: url)
    request.httpMethod = method
    request.addValue(apiKey, forHTTPHeaderField: "X-CMC_PRO_API_KEY")

    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    return URLSession.shared.dataTaskPublisher(for: request)
        .receive(on: DispatchQueue.global())
        .map { response in
          response.data
        }
        .receive(on: DispatchQueue.main)
        .decode(type: T.self, decoder: decoder)
        .eraseToAnyPublisher()
  }

  func createURL(_ path: String, query: [URLQueryItem] = []) -> URL {
    var components = URLComponents()

    components.scheme = "https"
    components.host = "pro-api.coinmarketcap.com"
    components.path = "/v1\(path)"
    components.queryItems = query

    return components.url!
  }
}
