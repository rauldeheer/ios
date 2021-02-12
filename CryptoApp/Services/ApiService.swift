import Foundation
import Combine

final class ApiService {
  func receiveData<T: Decodable>(_ url: URL, method: String = "GET") -> AnyPublisher<T, Error> {
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.addValue("12eec904-28cc-46e5-b508-d291a26d33e2", forHTTPHeaderField: "X-CMC_PRO_API_KEY")

    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    return URLSession.shared.dataTaskPublisher(for: request)
        .map { response in
          response.data
        }
        .decode(type: T.self, decoder: decoder)
        .receive(on: DispatchQueue.main)
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
