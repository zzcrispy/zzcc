import SwiftUI

/// 已打开日记后的内页浏览器。
/// TabView 的 page 样式会根据手指横向拖动距离完成分页切换。
struct DiaryPagesView: View {
    let onClose: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var selectedPage = 0
    @State private var showsControls = false
    @State private var bookmarkedPages: Set<String> = []
    @State private var activeSheet: ReaderSheet?

    private let pages = ["diaryPage1", "diaryPage2", "diaryPage3"]

    var body: some View {
        // 只让背景分页器延伸到安全区外；操作栏仍在安全区内布局。
        // 使用 overlay 而非 safeAreaInset，显隐操作栏不会挤压或缩放内页。
        pageBrowser
            .overlay(alignment: .top) {
                if showsControls {
                    DiaryPageTopBar(onBack: onClose) {
                        activeSheet = .overview
                    }
                    .transition(controlTransition(from: .top))
                }
            }
            .overlay(alignment: .bottomLeading) {
                bottomOverlay
            }
            .background(DiaryTheme.pageBackground.ignoresSafeArea())
            // 内页素材和操作栏均为浅色，让系统状态栏始终保持深色文字。
            .preferredColorScheme(.light)
            .sheet(item: $activeSheet) { sheet in
                NavigationStack {
                    Group {
                        switch sheet {
                        case .overview:
                            DiaryPagesOverview(
                                pages: pages,
                                selectedPage: selectedPage
                            ) { index in
                                // 缩略图直接定位，不播放跨越多页的翻页动画。
                                selectedPage = index
                                activeSheet = nil
                            }
                        case .pending(let action):
                            ContentUnavailableView(
                                "待开发",
                                systemImage: action.systemImage,
                                description: Text("\(action.rawValue)功能待开发，当前仅展示入口。")
                            )
                            .navigationTitle(action.rawValue)
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("关闭") { activeSheet = nil }
                        }
                    }
                }
                .presentationDragIndicator(.visible)
            }
            .accessibilityAction(.escape, onClose)
    }

    private var pageBrowser: some View {
        TabView(selection: $selectedPage) {
            ForEach(pages.indices, id: \.self) { index in
                GeometryReader { proxy in
                    // 保留现有等比完整展示方式，不裁切图片里的正文。
                    Image(pages[index])
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .background(DiaryTheme.pageBackground)
                        .contentShape(Rectangle())
                        // 手势仅绑定页面；点击工具栏按钮不会触发显隐。
                        .onTapGesture(perform: toggleControls)
                        .accessibilityLabel("第 \(index + 1) 页日记")
                        .accessibilityHint("轻点两下显示或隐藏操作栏，左右翻页浏览日记")
                        .accessibilityAddTraits(.isButton)
                        .accessibilityAction(named: "显示或隐藏操作栏", toggleControls)
                        .accessibilityIdentifier("diary.page.\(index + 1)")
                }
                .ignoresSafeArea()
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
    }

    private var bottomOverlay: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(selectedPage + 1)/\(pages.count)")
                .font(.system(size: 14).monospacedDigit())
                .foregroundStyle(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(.black.opacity(0.62), in: RoundedRectangle(cornerRadius: 10))
                .padding(.leading, 24)
                .padding(.bottom, 12)
                .accessibilityLabel("第 \(selectedPage + 1) 页，共 \(pages.count) 页")
                .accessibilityIdentifier("diary.pageCounter")
                .allowsHitTesting(false)

            // 页码和底栏在同一个 VStack，底栏出现时页码同步向上移动。
            if showsControls {
                DiaryPageBottomBar(
                    isBookmarked: bookmarkedPages.contains(pages[selectedPage]),
                    onAction: handleAction
                )
                .transition(controlTransition(from: .bottom))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // 上下操作栏和页码共用同一次动画事务；背景分页器尺寸保持不变。
    private func toggleControls() {
        let animation: Animation = reduceMotion
            ? .easeInOut(duration: 0.18)
            : .spring(response: 0.38, dampingFraction: 0.82)
        withAnimation(animation) {
            showsControls.toggle()
        }
    }

    private func controlTransition(from edge: Edge) -> AnyTransition {
        reduceMotion ? .opacity : .move(edge: edge).combined(with: .opacity)
    }

    private func handleAction(_ action: DiaryPageAction) {
        switch action {
        case .bookmark:
            // 前端收藏状态按页独立，仅在本次内页浏览期间保留。
            let page = pages[selectedPage]
            if bookmarkedPages.contains(page) {
                bookmarkedPages.remove(page)
            } else {
                bookmarkedPages.insert(page)
            }
        case .save, .forward, .regenerate, .delete:
            activeSheet = .pending(action)
        }
    }

    private enum ReaderSheet: Identifiable {
        case overview
        case pending(DiaryPageAction)

        var id: String {
            switch self {
            case .overview: "overview"
            case .pending(let action): action.rawValue
            }
        }
    }
}

#Preview {
    DiaryPagesView(onClose: {})
}
