import Foundation

class TramStopsViewModel: ObservableObject {
    
    @Published var tramStopsList: [TramStop] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var showErrorAlert = false
    
    private let tramStopsRepository: TramStopsRepository
    
    init(tramStopsRepository: TramStopsRepository) {
        self.tramStopsRepository = tramStopsRepository
    }
    
    @MainActor
    func getTramStops() async {
        isLoading = true
        do {
            tramStopsList = try await tramStopsRepository.getTramStops()
            showErrorAlert = false
        } catch {
            self.error = error
            print("Error al cargar paradas de tranvía:", error)
            showErrorAlert = true
        }
        isLoading = false
    }
    
    @MainActor
    func isFavorite(tramStop: TramStop) -> Bool {
        return tramStopsRepository.isFavorite(tramStop: tramStop)
    }
    
    @MainActor
    func addFavorite(tramStop: TramStop) {
        tramStopsRepository.addFavorite(tramStop: tramStop)
    }
    
    @MainActor
    func removeFavorite(tramStop: TramStop) {
        tramStopsRepository.removeFavorite(tramStop: tramStop)
    }
}
