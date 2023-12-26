import Foundation

struct LiveBusStopsRemoteService: BusStopsRemoteService {
    
    private let networkClient: NetworkClient
    private let baseURL = "https://www.zaragoza.es/sede/servicio/urbanismo-infraestructuras/transporte-urbano/"
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getBusStops() async throws -> [BusStop] {
        guard let url = URL(string: baseURL + "poste-autobus.json") else {
            throw NetworkError.badUrl
        }
        let urlRequest = URLRequest(url: url)
        let response: APIResponse<BusStop> = try await networkClient.call(urlRequest: urlRequest)
        return response.result
    }
    
    func getBusStopDataById(busStopId: String) async throws -> BusStopData {
        guard let encodedBusStopId = busStopId.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let url = URL(string: baseURL + "poste-autobus/\(encodedBusStopId).json") else {
            throw NetworkError.badUrl
        }
        let urlRequest = URLRequest(url: url)
        let response: BusStopData = try await networkClient.call(urlRequest: urlRequest)
        return response
    }
}
