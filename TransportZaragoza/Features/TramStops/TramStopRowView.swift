import SwiftUI

struct TramStopRowView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var viewModel: TramStopsViewModel
    let tramStop: TramStop
    
    @State private var isFavorite: Bool
    
    init(tramStop: TramStop, viewModel: TramStopsViewModel) {
        self.tramStop = tramStop
        self.viewModel = viewModel
        _isFavorite = State(initialValue: viewModel.isFavorite(tramStop: tramStop))
    }
    
    var body: some View {
        
        HStack {
            Image(systemName: "tram.fill")
                .foregroundColor(.blue)
                .font(.system(size: 24))
            VStack(alignment: .leading) {
                Text(tramStop.title)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .lineLimit(1)
                Text("Parada: \(tramStop.id)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            Spacer()
            Image(systemName: isFavorite ? "star.fill" : "star")
                .foregroundColor(.yellow)
                .font(.system(size: 24))
                .onTapGesture {
                    isFavorite.toggle()
                    if isFavorite {
                        viewModel.addFavorite(tramStop: tramStop)
                    } else {
                        viewModel.removeFavorite(tramStop: tramStop)
                    }
                }
        }
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.createTramStopRowView(tramStop: .example).environmentObject(coordinator)
}
