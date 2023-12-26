import Foundation

struct UserDefaultsBusStopsLocalService: BusStopsLocalService {
    
    private let busStopsKey = "busStops"
    private let favoritesKey = "favBusStops"
    
    func getBusStops() throws -> [BusStop] {
        guard let data = UserDefaults.standard.data(forKey: busStopsKey) else {
            return []
        }
        return try JSONDecoder().decode([BusStop].self, from: data)
    }
    
    func save(busStops: [BusStop]) throws {
        let data = try JSONEncoder().encode(busStops)
        UserDefaults.standard.set(data, forKey: busStopsKey)
    }
    
    func isFavorite(busStop: BusStop, busLine: String) -> Bool {
        let favorites = getFavorites()
        return favorites.contains(where: { $0.id == busStop.id && $0.busLine == busLine })
    }
    
    func addFavorite(busStop: BusStop, busLine: String) {
        var favorites = getFavorites()
        let newFavorite = BusStop(id: busStop.id, title: busStop.title, location: busStop.location, busLine: busLine)
        if !favorites.contains(where: { $0.id == newFavorite.id && $0.busLine == newFavorite.busLine }) {
            favorites.append(newFavorite)
            saveFavorites(favorites)
        }
    }
    
    func removeFavorite(busStop: BusStop, busLine: String) {
        var favorites = getFavorites()
        favorites.removeAll(where: { $0.id == busStop.id && $0.busLine == busLine })
        saveFavorites(favorites)
    }
    
    func getFavorites() -> [BusStop] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else { return [] }
        let decoder = JSONDecoder()
        return (try? decoder.decode([BusStop].self, from: data)) ?? []
    }
    
    private func saveFavorites(_ favorites: [BusStop]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
}
