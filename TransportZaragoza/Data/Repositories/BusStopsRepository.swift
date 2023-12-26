import Foundation

class BusStopsRepository {
    
    private let remoteService: LiveBusStopsRemoteService
    private let localService: UserDefaultsBusStopsLocalService
    private var error: Error?
    
    init(remoteService: LiveBusStopsRemoteService, localService: UserDefaultsBusStopsLocalService) {
        self.remoteService = remoteService
        self.localService = localService
    }
    
    func getBusStops(updateData: Bool = false) async throws -> [BusStop] {
        if updateData {
            do {
                let remoteBusStops = try await remoteService.getBusStops()
                try localService.save(busStops: remoteBusStops)
                return remoteBusStops
            } catch let error {
                self.error = error
                print("Error al cargar paradas de autobús desde remoto:", error)
                throw error
            }
        } else {
            let localBusStops = try localService.getBusStops()
            if !localBusStops.isEmpty {
                return localBusStops
            }
            let remoteBusStops = try await remoteService.getBusStops()
            try localService.save(busStops: remoteBusStops)
            return remoteBusStops
        }
    }
    
    func getBusStopDataById(busStopId: String) async throws -> BusStopData {
        do {
            let busStopData = try await remoteService.getBusStopDataById(busStopId: busStopId)
            return busStopData
        } catch let error {
            self.error = error
            print("Error al obtener datos de la parada de autobús:", error)
            throw error
        }
    }
    
    func getBusStopsByLine(busLine: String) async throws -> [BusStop] {
        let allBusStops = try await getBusStops()
        return allBusStops.filter { $0.title.extractLines().contains(busLine) }
    }
        
    func isFavorite(busStop: BusStop, busLine: String) -> Bool {
        return localService.isFavorite(busStop: busStop, busLine: busLine)
    }
    
    func addFavorite(busStop: BusStop, busLine: String) {
        localService.addFavorite(busStop: busStop, busLine: busLine)
    }
    
    func removeFavorite(busStop: BusStop, busLine: String) {
        localService.removeFavorite(busStop: busStop, busLine: busLine)
    }
    
    func getFavorites() -> [BusStop] {
        return localService.getFavorites()
    }
}


