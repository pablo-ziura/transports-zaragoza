import SwiftUI

struct ContentView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var showSplashScreen = true
    
    var body: some View {
        Group {
            if showSplashScreen {
                SplashScreenView(
                    viewModel: coordinator.createSplashScreenViewModel(),
                    isActive: $showSplashScreen
                )
            } else {
                MainMenuView()
            }
        }
    }
}

struct MainMenuView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    let buttonSize: CGFloat = 125
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                Image("app_logo_image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle()
                        .stroke(Color.orange, lineWidth: 5))
                Spacer()
                NavigationLink(destination: coordinator.createTramStopListView()) {
                    Image("button_tram")
                        .resizable()
                        .scaledToFill()
                        .frame(width: buttonSize, height: buttonSize)
                        .cornerRadius(buttonSize / 4)
                }
                Spacer()
                NavigationLink(destination: coordinator.createBusLinesView()) {
                    Image("button_bus")
                        .resizable()
                        .scaledToFill()
                        .frame(width: buttonSize, height: buttonSize)
                        .cornerRadius(buttonSize / 4)
                }
                Spacer()
                NavigationLink(destination: coordinator.createFavoriteListView()) {
                    Image("button_fav")
                        .resizable()
                        .scaledToFill()
                        .frame(width: buttonSize, height: buttonSize)
                        .cornerRadius(buttonSize / 4)
                }
                Spacer()
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    let coordinator = Coordinator()
    return ContentView().environmentObject(coordinator)
}
