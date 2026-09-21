import Lottie
import SwiftUI

/// 点击日记后播放一次的翻书动画。
struct DiaryAnimationSlot: UIViewRepresentable {
    let onProgress: (CGFloat) -> Void
    let onFinished: () -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onProgress: onProgress, onFinished: onFinished)
    }

    func makeUIView(context: Context) -> LottieAnimationView {
        let animationView = LottieAnimationView(name: "diary_book_flip")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.backgroundColor = .clear
        animationView.isUserInteractionEnabled = false
        context.coordinator.start(animationView)
        return animationView
    }

    func updateUIView(_ uiView: LottieAnimationView, context: Context) { }

    static func dismantleUIView(_ uiView: LottieAnimationView, coordinator: Coordinator) {
        coordinator.cancel()
        uiView.stop()
    }

    final class Coordinator: NSObject {
        private let onProgress: (CGFloat) -> Void
        private let onFinished: () -> Void
        private weak var animationView: LottieAnimationView?
        private var displayLink: CADisplayLink?
        private var lastProgress: CGFloat = -1
        private var hasFinished = false
        private var isCancelled = false

        init(onProgress: @escaping (CGFloat) -> Void, onFinished: @escaping () -> Void) {
            self.onProgress = onProgress
            self.onFinished = onFinished
            super.init()
        }

        func start(_ view: LottieAnimationView) {
            animationView = view
            // 在视图挂载后开始，避免 makeUIView/updateUIView 中修改 SwiftUI 状态。
            DispatchQueue.main.async { [weak self, weak view] in
                guard let self, let view, !self.isCancelled else { return }

                guard view.animation != nil else {
                    self.finish()
                    return
                }

                let link = CADisplayLink(target: self, selector: #selector(self.updateProgress))
                self.displayLink = link
                link.add(to: .main, forMode: .common)

                view.play { [weak self] completed in
                    guard completed else { return }
                    self?.finish()
                }
            }
        }

        @objc private func updateProgress() {
            guard !hasFinished, !isCancelled, let animationView else { return }
            let progress = CGFloat(animationView.realtimeAnimationProgress)
            guard progress != lastProgress else { return }
            lastProgress = progress
            onProgress(progress)
        }

        private func finish() {
            guard !hasFinished, !isCancelled else { return }
            hasFinished = true
            displayLink?.invalidate()
            displayLink = nil
            onProgress(1)
            onFinished()
        }

        func cancel() {
            isCancelled = true
            displayLink?.invalidate()
            displayLink = nil
            animationView = nil
        }
    }
}
