import Foundation

class SplashScreenViewModel: ObservableObject {
    
    @Published var busStops: [BusStop] = []
    @Published var tramStops: [TramStop] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var updateData = false

    private let busStopsRepository: BusStopsRepository
    private let tramStopsRepository: TramStopsRepository

    init(busStopsRepository: BusStopsRepository, tramStopsRepository: TramStopsRepository) {
        self.busStopsRepository = busStopsRepository
        self.tramStopsRepository = tramStopsRepository
    }
    
    @MainActor
    func getBusStops() async {
        isLoading = true
        do {
            busStops = try await busStopsRepository.getBusStops(updateData: updateData)
        } catch (let error) {
            self.error = error
            print("Error al cargar paradas de autobús:", error)
        }
        isLoading = false
    }
    
    @MainActor
    func getTramStops() async {
        isLoading = true
        do {
            tramStops = try await tramStopsRepository.getTramStops(updateData: updateData)
        } catch (let error) {
            self.error = error
            print("Error al cargar paradas de tranvía:", error)
        }
        isLoading = false
    }
}
