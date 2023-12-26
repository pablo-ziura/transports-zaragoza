import Foundation

protocol TramStopsLocalService {
    func getTramStops() throws -> [TramStop]
    func save(tramStops: [TramStop]) throws
    func isFavorite(tramStop: TramStop) -> Bool
    func addFavorite(tramStop: TramStop)
    func removeFavorite(tramStop: TramStop)
    func getFavorites() -> [TramStop]
}
