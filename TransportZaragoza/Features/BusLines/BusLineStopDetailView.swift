import SwiftUI
import MapKit

struct BusLineStopDetailView: View {
    
    let busStop: BusStop
    
    @StateObject private var viewModel: BusLineDetailViewModel
    
    init(busStop: BusStop, viewModel: BusLineDetailViewModel) {
        self.busStop = busStop
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        let bounds = MapCameraBounds(
            centerCoordinateBounds: MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: busStop.location.coordinates[1],
                    longitude: busStop.location.coordinates[0]),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.05,
                    longitudeDelta: 0.05)),
            minimumDistance: 500,
            maximumDistance: 5000
        )

        VStack {
            Map(bounds: bounds) {
                Annotation(busStop.title.extractAddress(),
                           coordinate: CLLocationCoordinate2D(
                            latitude: busStop.location.coordinates[1],
                            longitude: busStop.location.coordinates[0]), anchor: .bottom) {
                                VStack {
                                    Text("Parada:  \(busStop.id)")
                                    Image(systemName: "bus.fill")
                                }
                                .foregroundColor(.blue)
                                .padding()
                                .background(in: .ellipse)
                            }
            }
            .frame(height: 300)
            .cornerRadius(8)

            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else if let busStopData = viewModel.busStopData {
                VStack(alignment: .leading) {
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
        }
        .task {
            await viewModel.getBusStopData(busStopId: busStop.id)
        }
        .padding()
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.createBusLineStopDetailView(busStop: .example).environmentObject(coordinator)
}
