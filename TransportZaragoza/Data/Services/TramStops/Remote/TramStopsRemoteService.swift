import Foundation

protocol TramStopsRemoteService {
    func getTramStops() async throws -> [TramStop]
}
