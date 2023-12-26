import SwiftUI
import MapKit

struct BusLineDetailView: View {
    
    let busLine: String
    @StateObject private var viewModel: BusLineDetailViewModel
    @EnvironmentObject var coordinator: Coordinator
    @State private var selectedBusStopId: String? = nil
    
    init(viewModel: BusLineDetailViewModel, busLine: String) {
        self.busLine = busLine
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Map {
                ForEach(viewModel.busStops, id: \.id) { busStop in
                    Marker(busStop.title, coordinate: CLLocationCoordinate2D(
                        latitude: busStop.location.coordinates[1],
                        longitude: busStop.location.coordinates[0]))
                    .tint(busStop.id == selectedBusStopId ? .red : .gray)
                }
            }
            .frame(height: 300)
            .cornerRadius(8)
            .padding(.horizontal)
            .gesture(TapGesture().onEnded { _ in
                selectedBusStopId = nil
            })
            
            if viewModel.isLoading {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
                .frame(maxWidth: .infinity, alignment: .center)
            } else if let selectedBusStopId = selectedBusStopId {
                VStack(alignment: .center) {
                    Button(action: {
                        Task {
                            await viewModel.getBusStopData(busStopId: selectedBusStopId)
                        }
                    }) {
                        Image(systemName: "arrow.clockwise.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Actualizar")
                    }
                    
                    if let busStopData = viewModel.busStopData {
                        ForEach(busStopData.destinos, id: \.linea) { destino in
                            Section(header: Text("Línea \(destino.linea):").font(.headline)) {
                                Text("Próximo bus: \(destino.primero)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text("Siguiente bus: \(destino.segundo)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Divider()
                        }
                    }
                }
                .padding()            }

            List(viewModel.busStops.sorted(by: { $0.id < $1.id })) { busStop in
                Button(action: {
                    selectedBusStopId = busStop.id
                    Task {
                        await viewModel.getBusStopData(busStopId: busStop.id)
                    }
                }) {
                    coordinator.createBusLineStopRowView(busStop: busStop, busLine: busLine)
                }
            }
            .onAppear {
                Task {
                    await viewModel.getBusStopsByLine()
                }
            }
        }
        .alert("Error", isPresented: $viewModel.showErrorAlertForStops) {
            Button("Reintentar") {
                Task {
                    await viewModel.getBusStopsByLine()
                }
            }
            Button("Cancelar", role: .cancel) { }
        } message: {
            Text("Error al cargar las paradas")
        }
        .alert("Error", isPresented: $viewModel.showErrorAlertForStopDetails) {
            Button("Reintentar") {
                if let selectedBusStopId = selectedBusStopId {
                    Task {
                        await viewModel.getBusStopData(busStopId: selectedBusStopId)
                    }
                }
            }
            Button("Cancelar", role: .cancel) { }
        } message: {
            Text("Error al cargar información de la parada")
        }

    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.createBusLineDetailView(busLine: "22" ).environmentObject(coordinator)
}
