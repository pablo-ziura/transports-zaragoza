import SwiftUI

struct SplashScreenView: View {
    
    @Binding var isActive: Bool
    @StateObject private var viewModel: SplashScreenViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    init(
        viewModel: SplashScreenViewModel,
        isActive: Binding<Bool>
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self._isActive = isActive
    }
    
    var body: some View {
            VStack{
                Image("app_logo_image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350, height: 350)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.orange, lineWidth: 5))
            Spacer()
                LottieView(name: "Animation")
                    .scaleEffect(0.25)
                    .frame(width: 100, height: 100)
            }
            .padding(48)
            .onAppear {
                let minimumDisplayTime = 3.0 // Segundos
                let startTime = Date()
                Task {
                    viewModel.updateData = true
                    await viewModel.getBusStops()
                    await viewModel.getTramStops()

                    let elapsedTime = Date().timeIntervalSince(startTime)
                    if elapsedTime < minimumDisplayTime {
                        try? await Task.sleep(nanoseconds: UInt64((minimumDisplayTime - elapsedTime) * 1_000_000_000))
                    }
                    
                    DispatchQueue.main.async {
                        isActive = false
                    }
                }
            }
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.createSplashScreenView(isActive: .constant(true)).environmentObject(coordinator)
}
