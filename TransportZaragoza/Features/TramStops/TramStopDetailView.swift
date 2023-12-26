import SwiftUI
import MapKit

struct TramStopDetailView: View {
    
    let tramStop: TramStop
    
    var body: some View {
        
        let bounds = MapCameraBounds(
            centerCoordinateBounds: MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: tramStop.location.coordinates[1],
                    longitude: tramStop.location.coordinates[0]),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.05,
                    longitudeDelta: 0.05)),
            minimumDistance: 500,
            maximumDistance: 5000
        )

        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Map(bounds: bounds) {
                    Annotation(tramStop.title,
                               coordinate: CLLocationCoordinate2D(
                                latitude: tramStop.location.coordinates[1],
                                longitude: tramStop.location.coordinates[0]), anchor: .bottom) {
                        VStack {
                            Text("Parada:  \(tramStop.id)")
                            Image(systemName: "tram.fill")
                        }
                        .foregroundColor(.blue)
                        .padding()
                        .background(in: .ellipse)
                    }
                }                
                .frame(height: 300)
                .cornerRadius(8)

                GroupBox(label: Label(tramStop.title, systemImage: "tram.fill")) {
                    Text("Última Actualización: \(tramStop.updateTime)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if let destinos = tramStop.destinos {
                    GroupBox(label: Text("Tiempo de llegada:").font(.title3)) {
                        ForEach(destinos, id: \.linea) { destino in
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Línea: \(destino.linea)")
                                    .font(.headline)
                                Text("Destino: \(destino.destino)")
                                Text("Tiempo estimado: \(destino.minutos) min.")
                            }
                            .padding(.bottom, 5)
                        }
                    }
                } else {
                    Text("No hay información de destinos disponible.")
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.createTramStopDetailView(tramStop: .example).environmentObject(coordinator)
}
