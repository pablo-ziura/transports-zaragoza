import SwiftUI

struct FavoriteListView: View {
    
    @StateObject private var viewModel: FavoriteListViewModel
    @EnvironmentObject var coordinator: Coordinator
    @State private var selectedTransport: Int = 0
        
    init(
        viewModel: FavoriteListViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Text("Favoritos")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.orange)
            .cornerRadius(10)
            .padding(.bottom, 5)
        NavigationStack {
            VStack {
                Picker("Dirección", selection: $selectedTransport) {
                    Text("Tranvía").tag(0)
                    Text("Autobús").tag(1)
                }
                .pickerStyle(.segmented)
                .padding()
                
                if selectedTransport == 0 {
                    List(viewModel.favoriteTramStops, id: \.id) { tramStop in
                        makeNavigationLinkTramStop(for: tramStop)
                    }
                    .task {
                        await viewModel.getFavoritesTramStops()
                    }
                } else {
                    List(viewModel.favoriteBusStops, id: \.id) { busStop in
                        makeNavigationLinkBusStop(for: busStop)
                    }
                    .task {
                        await viewModel.getFavoritesBusStops()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
        
    private func makeNavigationLinkTramStop(for tramStop: TramStop) -> some View {
        NavigationLink {
            coordinator.createTramStopDetailView(tramStop: tramStop)
        } label: {
            coordinator.createTramStopRowView(tramStop: tramStop)
        }
    }
    
    private func makeNavigationLinkBusStop(for busStop: BusStop) -> some View {
        NavigationLink {
            coordinator.createBusLineStopDetailView(busStop: busStop)
        } label: {
            coordinator.createBusLineStopRowView(busStop: busStop, busLine: busStop.busLine ?? "Unknown")
        }
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.createFavoriteListView().environmentObject(coordinator)
}
