import SwiftUI

@main
struct TransportZaragozaApp: App {
    
    let coordinator = Coordinator()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(coordinator)
        }
    }
}
