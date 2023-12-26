import Foundation

protocol BusStopsLocalService {
    func getBusStops() throws -> [BusStop]
    func save(busStops: [BusStop]) throws
    func isFavorite(busStop: BusStop, busLine: String) -> Bool
    func addFavorite(busStop: BusStop, busLine: String)
    func removeFavorite(busStop: BusStop, busLine: String)
    func getFavorites() -> [BusStop]
}
