import Lottie
import SwiftUI

/// 点击日记后播放一次的翻书动画。
struct DiaryAnimationSlot: UIViewRepresentable {
    let onFinished: () -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onFinished: onFinished)
    }

    func makeUIView(context: Context) -> LottieAnimationView {
        let animationView = LottieAnimationView(name: "diary_book_flip")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.backgroundColor = .clear
        animationView.isUserInteractionEnabled = false
        animationView.play { completed in
            guard completed else { return }
            context.coordinator.finish()
        }
        return animationView
    }

    func updateUIView(_ uiView: LottieAnimationView, context: Context) { }

    final class Coordinator {
        private let onFinished: () -> Void
        private var hasFinished = false

        init(onFinished: @escaping () -> Void) {
            self.onFinished = onFinished
        }

        func finish() {
            guard !hasFinished else { return }
            hasFinished = true
            onFinished()
        }
    }
}
