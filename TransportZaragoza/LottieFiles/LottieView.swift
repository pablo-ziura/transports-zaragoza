import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    typealias UIViewType = LottieAnimationView
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: "Animation")
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }
    
    func updateUIView(_ uiView: Lottie.LottieAnimationView, context: Context) {
        // TODO
    }
}

#Preview {
    LottieView(name: "Animation")
}
