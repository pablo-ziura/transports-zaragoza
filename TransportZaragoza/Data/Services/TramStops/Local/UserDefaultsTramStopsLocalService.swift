import Foundation

struct UserDefaultsTramStopsLocalService: TramStopsLocalService {
    
    private let tramStopsKey = "tramStops"
    private let favoritesKey = "favTramStops"
    
    func getTramStops() throws -> [TramStop] {
        guard let data = UserDefaults.standard.data(forKey: tramStopsKey) else {
            return []
        }
        return try JSONDecoder().decode([TramStop].self, from: data)
    }
    
    func save(tramStops: [TramStop]) throws {
        let data = try JSONEncoder().encode(tramStops)
        UserDefaults.standard.set(data, forKey: tramStopsKey)
    }
    
    func isFavorite(tramStop: TramStop) -> Bool {
        let favorites = getFavorites()
        return favorites.contains(where: { $0.id == tramStop.id })
    }
    
    func addFavorite(tramStop: TramStop) {
        var favorites = getFavorites()
        if !favorites.contains(where: { $0.id == tramStop.id }) {
            favorites.append(tramStop)
            saveFavorites(favorites)
        }
    }
    
    func removeFavorite(tramStop: TramStop) {
        var favorites = getFavorites()
        favorites.removeAll(where: { $0.id == tramStop.id })
        saveFavorites(favorites)
    }
    
    func getFavorites() -> [TramStop] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else { return [] }
        let decoder = JSONDecoder()
        return (try? decoder.decode([TramStop].self, from: data)) ?? []
    }
    
    private func saveFavorites(_ favorites: [TramStop]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
}
