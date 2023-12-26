import SwiftUI

struct BusLinesView: View {
    
    @StateObject private var viewModel: BusLinesViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    init(viewModel: BusLinesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text("Líneas de autobús")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.orange)
            .cornerRadius(10)
            .padding(.bottom, 5)
        NavigationStack {
            List {
                ForEach(Array(viewModel.busLines.keys.sorted()), id: \.self) { busLine in
                    makeNavigationLink(for: busLine)
                }
            }
            .navigationBarHidden(true)
            .task {
                await viewModel.getBusLines()
            }
        }
    }
    
    func makeNavigationLink(for busLine: String) -> some View {
        NavigationLink {
            coordinator.createBusLineDetailView(busLine: busLine)
        } label: {
            VStack(alignment: .leading) {
                Text(busLine)
                    .font(.headline)
            }
        }
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.createBusLinesView().environmentObject(coordinator)
}
