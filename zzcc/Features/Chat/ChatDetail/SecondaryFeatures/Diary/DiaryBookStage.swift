import SwiftUI

/// 日记首页的封面视觉。
struct DiaryBookStage: View {
    var body: some View {
        Image("diaryBookCover")
            .resizable()
            .scaledToFit()
            // 此组件只展示封面；打开和返回的交互统一由 DiaryView 管理。
            .accessibilityHidden(true)
    }
}
