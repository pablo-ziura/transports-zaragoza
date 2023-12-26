import Foundation

protocol BusStopsRemoteService {
    
    func getBusStops() async throws -> [BusStop]
    func getBusStopDataById(busStopId: String) async throws -> BusStopData
    
}
