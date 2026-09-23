import SwiftUI

/// 日记首页的封面视觉。
struct DiaryBookStage: View {
    var isActive = true

    // 以封面原图 780 × 1220 为坐标系，动画随封面等比缩放。
    private let coverSize = CGSize(width: 780, height: 1220)
    private let iconCenter = CGPoint(x: 390, y: 598)
    private let animationSide: CGFloat = 420

    var body: some View {
        Image("diaryBookCover")
            .resizable()
            .scaledToFit()
            .overlay {
                GeometryReader { proxy in
                    let scale = min(
                        proxy.size.width / coverSize.width,
                        proxy.size.height / coverSize.height
                    )
                    let originX = (proxy.size.width - coverSize.width * scale) / 2
                    let originY = (proxy.size.height - coverSize.height * scale) / 2

                    DiaryCoverLoopAnimation(isActive: isActive)
                        .frame(
                            width: animationSide * scale,
                            height: animationSide * scale
                        )
                        .position(
                            x: originX + iconCenter.x * scale,
                            y: originY + iconCenter.y * scale
                        )
                }
                // 触摸交给外层的整本日记按钮，点动画也能继续触发翻书。
                .allowsHitTesting(false)
            }
            // 此组件只展示封面；打开和返回的交互统一由 DiaryView 管理。
            .accessibilityHidden(true)
    }
}
