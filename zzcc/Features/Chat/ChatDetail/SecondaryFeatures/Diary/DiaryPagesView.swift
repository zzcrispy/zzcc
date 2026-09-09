import SwiftUI

/// 已打开日记后的内页浏览器。
/// TabView 的 page 样式会根据手指横向拖动距离完成分页切换。
struct DiaryPagesView: View {
    let onClose: () -> Void

    private let pages = ["diaryPage1", "diaryPage2", "diaryPage3"]

    var body: some View {
        ZStack(alignment: .topTrailing) {
            TabView {
                ForEach(pages, id: \.self) { pageName in
                    GeometryReader { proxy in
                        Image(pageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .clipped()
                            .contentShape(Rectangle())
                    }
                    .background(DiaryTheme.background)
                }
            }

            Button("关闭", systemImage: "xmark") {
                onClose()
            }
            .labelStyle(.iconOnly)
            .font(.system(size: 17, weight: .semibold))
            .foregroundStyle(.primary)
            .frame(width: 40, height: 40)
            .background(.ultraThinMaterial, in: Circle())
            .padding(.top, 16)
            .padding(.trailing, 16)
            .accessibilityLabel("关闭日记内页")
        }
        .background(DiaryTheme.background)
        .ignoresSafeArea(.all)
        .tabViewStyle(.page(indexDisplayMode: .automatic))
        .indexViewStyle(.page(backgroundDisplayMode: .automatic))
    }
}
