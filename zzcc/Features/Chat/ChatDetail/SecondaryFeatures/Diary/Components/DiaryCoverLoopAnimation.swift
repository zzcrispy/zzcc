import Lottie
import SwiftUI

/// 封面中央「点击开启」循环动效，原始 dotLottie 资源存放于 Resources/Animations。
struct DiaryCoverLoopAnimation: View {
    let isActive: Bool

    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var isVisible = false

    private var playbackMode: LottiePlaybackMode {
        if reduceMotion {
            return .paused(at: .progress(0))
        }
        if isActive && isVisible && scenePhase == .active {
            return .playing(.fromProgress(0, toProgress: 1, loopMode: .loop))
        }
        return .paused(at: .currentFrame)
    }

    var body: some View {
        LottieView {
            try await DotLottieFile.named("diary_cover_loop")
        }
        .resizable()
        .animationSpeed(1.15)
        .playbackMode(playbackMode)
        .backgroundBehavior(.pauseAndRestore)
        .windowBackgroundBehavior(.pauseAndRestore)
        .onAppear { isVisible = true }
        .onDisappear { isVisible = false }
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }
}
