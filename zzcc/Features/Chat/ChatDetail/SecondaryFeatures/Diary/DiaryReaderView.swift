import SwiftUI

/// 同一导航层里完成「翻书动画 → 内页渐显」，返回仍由外层原生导航处理。
struct DiaryReaderView: View {
    let onClose: () -> Void
    let onOpeningFinished: () -> Void

    @State private var openingProgress: CGFloat = 0
    @State private var isOpening = true

    // JSON 实际进度的 35% 开始露出内页，85% 时完整显示。
    // 当前素材为 0.8 秒，对应约 0.28 秒开始、0.68 秒结束渐显。
    private let revealStart: CGFloat = 0.35
    private let revealEnd: CGFloat = 0.85

    private var revealProgress: CGFloat {
        let progress = min(max((openingProgress - revealStart) / (revealEnd - revealStart), 0), 1)
        // 平滑加速、减速；直接跟随播放进度，不叠加逐帧 withAnimation。
        return progress * progress * (3 - 2 * progress)
    }

    var body: some View {
        // overlay 不参与内页的尺寸计算，避免安全区和页码随动画层移除而跳动。
        DiaryPagesView(onClose: onClose)
            .allowsHitTesting(!isOpening)
            .accessibilityHidden(isOpening)
            .overlay {
                if isOpening {
                    ZStack {
                        // 背景必须与 JSON 一起淡出，否则会挡住下方的内页。
                        DiaryTheme.background
                            .ignoresSafeArea()

                        DiaryAnimationSlot(
                            onProgress: { openingProgress = $0 },
                            onFinished: finishOpening
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                    }
                    .compositingGroup()
                    .opacity(1 - revealProgress)
                    .transition(.identity)
                    .allowsHitTesting(false)
                    .accessibilityHidden(true)
                }
            }
            .background(DiaryTheme.pageBackground.ignoresSafeArea())
            .preferredColorScheme(.light)
    }

    private func finishOpening() {
        guard isOpening else { return }
        // 此时动画层已透明，只移除覆盖层，不 push、不改变导航栏或页面尺寸。
        openingProgress = 1
        isOpening = false
        onOpeningFinished()
    }
}
