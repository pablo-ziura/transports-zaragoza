import Foundation
import SwiftUI

class Coordinator: ObservableObject {
    
    private let busStopsRepository: BusStopsRepository
    private let tramStopsRepository: TramStopsRepository
    
    init() {
        
        let networkClient = URLSessionNetworkClient()
                
        let tramStopsRemoteService: LiveTramStopsRemoteService = LiveTramStopsRemoteService(networkClient: networkClient)
        
        let tramStopsLocalService: UserDefaultsTramStopsLocalService = UserDefaultsTramStopsLocalService()
        
        tramStopsRepository = TramStopsRepository(
            remoteService: tramStopsRemoteService,
            localService: tramStopsLocalService
        )
        
        let busStopsRemoteService: LiveBusStopsRemoteService = LiveBusStopsRemoteService(networkClient: networkClient)
        
        let busStopsLocalService: UserDefaultsBusStopsLocalService = UserDefaultsBusStopsLocalService()
            
        busStopsRepository = BusStopsRepository(
            remoteService: busStopsRemoteService,
            localService: busStopsLocalService
        )
        
    }
    
    func createSplashScreenViewModel() -> SplashScreenViewModel {
        SplashScreenViewModel(
            busStopsRepository: busStopsRepository,
            tramStopsRepository: tramStopsRepository
        )
    }
    
    func createSplashScreenView(isActive: Binding<Bool>) -> SplashScreenView {
        SplashScreenView(
            viewModel: createSplashScreenViewModel(),
            isActive: isActive
        )
    }
    
    private func createTramStopsListViewModel() -> TramStopsViewModel {
        TramStopsViewModel(tramStopsRepository: tramStopsRepository)
    }
    
    func createTramStopListView() -> TramStopsView {
        TramStopsView(
            viewModel: createTramStopsListViewModel()
        )
    }
    
    func createTramStopRowView(tramStop: TramStop) -> TramStopRowView {
        TramStopRowView(
            tramStop: tramStop,
            viewModel: createTramStopsListViewModel()
        )
    }
    
    func createTramStopDetailView(tramStop: TramStop) -> TramStopDetailView {
        TramStopDetailView(tramStop: tramStop)
    }
    
    private func createBusLinesViewModel() -> BusLinesViewModel {
        BusLinesViewModel(busStopsRepository: busStopsRepository)
    }
    
    func createBusLinesView() -> BusLinesView {
        BusLinesView(viewModel: createBusLinesViewModel())
    }
    
    private func createBusLineDetailViewModel(busLine: String) -> BusLineDetailViewModel {
        BusLineDetailViewModel(
            busStopsRepository: busStopsRepository,
            busLine: busLine)
    }
    
    func createBusLineStopRowView(busStop: BusStop, busLine: String) -> BusLineStopRowView {
        BusLineStopRowView(
            busStop: busStop,
            busLine: busLine,
            viewModel: createBusLineDetailViewModel(busLine: busLine)
        )
    }
    
    func createBusLineStopDetailView(busStop: BusStop) -> BusLineStopDetailView {
        BusLineStopDetailView(
            busStop: busStop,
            viewModel: createBusLineDetailViewModel(busLine: busStop.busLine ?? "Unknown")
        )
    }
    
    func createBusLineDetailView(busLine: String) -> BusLineDetailView {
        BusLineDetailView(
            viewModel: createBusLineDetailViewModel(busLine: busLine),
            busLine: busLine
        )
    }
    
    private func createFavoriteListViewModel() -> FavoriteListViewModel {
        FavoriteListViewModel(
            tramStopsRepository: tramStopsRepository,
            busStopsRepository: busStopsRepository
        )
    }
    
    func createFavoriteListView() -> FavoriteListView {
        FavoriteListView(viewModel: createFavoriteListViewModel())
    }
}
