import Foundation

class BusLineDetailViewModel: ObservableObject {
    
    @Published var busStops: [BusStop] = []
    @Published var busStopData: BusStopData?
    @Published var isLoading = false
    @Published var error: Error?
    
    @Published var showErrorAlertForStops = false
    @Published var showErrorAlertForStopDetails = false
    
    private let busStopsRepository: BusStopsRepository
    private let busLine: String
    
    init(busStopsRepository: BusStopsRepository, busLine: String) {
        self.busStopsRepository = busStopsRepository
        self.busLine = busLine
    }
    
    @MainActor
    func getBusStopsByLine() async {
        isLoading = true
        do {
            busStops = try await busStopsRepository.getBusStopsByLine(busLine: busLine)
            showErrorAlertForStops = false
        } catch {
            self.error = error
            print("Error al obtener las paradas detalladas para la línea \(busLine):", error)
            showErrorAlertForStops = true
        }
        isLoading = false
    }
    
    @MainActor
    func getBusStopData(busStopId: String) async {
        isLoading = true
        do {
            busStopData = try await busStopsRepository.getBusStopDataById(busStopId: busStopId)
            showErrorAlertForStopDetails = false
        } catch {
            self.error = error
            print("Error al obtener datos de la parada de autobús con ID \(busStopId):", error)
            showErrorAlertForStopDetails = true
        }
        isLoading = false
    }

    @MainActor
    func isFavorite(busStop: BusStop, busLine: String) -> Bool {
        return busStopsRepository.isFavorite(busStop: busStop, busLine: busLine)
    }
    
    @MainActor
    func addFavorite(busStop: BusStop, busLine: String) {
        busStopsRepository.addFavorite(busStop: busStop, busLine: busLine)
    }
    
    @MainActor
    func removeFavorite(busStop: BusStop, busLine: String) {
        busStopsRepository.removeFavorite(busStop: busStop, busLine: busLine)
    }
}
