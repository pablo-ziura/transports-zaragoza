import SwiftUI

struct BusLineStopRowView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var viewModel: BusLineDetailViewModel
    let busStop: BusStop
    let busLine: String
    
    @State private var isFavorite: Bool
    
    init(busStop: BusStop, busLine: String, viewModel: BusLineDetailViewModel) {
        self.busStop = busStop
        self.busLine = busLine
        self.viewModel = viewModel
        _isFavorite = State(initialValue: viewModel.isFavorite(busStop: busStop, busLine: busLine))
    }
    
    var body: some View {
        
        HStack {
            Image(systemName: "bus.fill")
                .foregroundColor(.blue)
                .font(.system(size: 24))
            
            VStack(alignment: .leading) {
                Text(busStop.title.extractAddress().toTitleCase())
                    .font(.headline)
                    .lineLimit(1)
                Text("Parada: \(busStop.id)")
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
                        viewModel.addFavorite(busStop: busStop, busLine: busLine)
                    } else {
                        viewModel.removeFavorite(busStop: busStop, busLine: busLine)
                    }
                }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.createBusLineStopRowView(busStop: .example, busLine: "22").environmentObject(coordinator)
}
