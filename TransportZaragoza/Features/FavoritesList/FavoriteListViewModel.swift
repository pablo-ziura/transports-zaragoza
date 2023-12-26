import Foundation

class FavoriteListViewModel: ObservableObject {
    
    @Published var favoriteTramStops: [TramStop] = []
    @Published var favoriteBusStops: [BusStop] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let tramStopsRepository: TramStopsRepository
    private let busStopsRepository: BusStopsRepository

    init(tramStopsRepository: TramStopsRepository, busStopsRepository: BusStopsRepository) {
        self.tramStopsRepository = tramStopsRepository
        self.busStopsRepository = busStopsRepository
    }
    
    @MainActor
    func getFavoritesTramStops() async {
        favoriteTramStops = tramStopsRepository.getFavorites()
    }
    
    @MainActor
    func getFavoritesBusStops() async {
        favoriteBusStops = busStopsRepository.getFavorites()
    }
    
}
