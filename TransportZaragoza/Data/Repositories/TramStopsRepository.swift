import Foundation

class TramStopsRepository {
    
    private let remoteService: LiveTramStopsRemoteService
    private let localService: UserDefaultsTramStopsLocalService
    private var error: Error?
    
    init(remoteService: LiveTramStopsRemoteService, localService: UserDefaultsTramStopsLocalService) {
        self.remoteService = remoteService
        self.localService = localService
    }
    
    func getTramStops(updateData: Bool = false) async throws -> [TramStop] {
        if updateData {
            do {
                let remoteTramStops = try await remoteService.getTramStops()
                try localService.save(tramStops: remoteTramStops)
                return remoteTramStops
            } catch let error {
                self.error = error
                print("Error al cargar paradas de tranvía desde remoto:", error)
                throw error
            }
        } else {
            let localTramStops = try localService.getTramStops()
            if !localTramStops.isEmpty {
                return localTramStops
            }
            let remoteTramStops = try await remoteService.getTramStops()
            try localService.save(tramStops: remoteTramStops)
            return remoteTramStops
        }
    }
    
    func isFavorite(tramStop: TramStop) -> Bool {
        return localService.isFavorite(tramStop: tramStop)
    }
    
    func addFavorite(tramStop: TramStop) {
        localService.addFavorite(tramStop: tramStop)
    }
    
    func removeFavorite(tramStop: TramStop) {
        localService.removeFavorite(tramStop: tramStop)
    }
    
    func getFavorites() -> [TramStop] {
        return localService.getFavorites()
    }
}
