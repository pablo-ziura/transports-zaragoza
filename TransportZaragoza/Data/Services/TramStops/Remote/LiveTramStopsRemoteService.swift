import Foundation

struct LiveTramStopsRemoteService: TramStopsRemoteService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getTramStops() async throws -> [TramStop] {
        guard let url = URL(string: "https://www.zaragoza.es/sede/servicio/urbanismo-infraestructuras/transporte-urbano/parada-tranvia.json") else {
            throw NetworkError.badUrl
        }
        
        let urlRequest = URLRequest(url: url)
        
        let response: APIResponse<TramStop> = try await networkClient.call(urlRequest: urlRequest)
        return response.result
    }
}
