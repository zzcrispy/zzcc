import SwiftUI

/// 内页操作入口。后续在 DiaryPagesView.handleAction 中接入对应功能。
enum DiaryPageAction: String, CaseIterable, Identifiable {
    case bookmark = "收藏"
    case save = "保存"
    case forward = "转发"
    case regenerate = "重新生成"
    case delete = "删除"

    var id: String { rawValue }

    var systemImage: String {
        switch self {
        case .bookmark: "bookmark"
        case .save: "arrow.down.to.line"
        case .forward: "arrowshape.turn.up.right.fill"
        case .regenerate: "arrow.counterclockwise"
        case .delete: "trash.fill"
        }
    }
}

struct DiaryPageTopBar: View {
    let onBack: () -> Void
    let onOverview: () -> Void

    var body: some View {
        HStack {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 22, weight: .medium))
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .accessibilityLabel("返回日记封面")

            Spacer()

            Button(action: onOverview) {
                Image(systemName: "square.grid.2x2")
                    .font(.system(size: 22, weight: .medium))
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .accessibilityLabel("预览所有笔记")
        }
        .buttonStyle(.plain)
        .foregroundStyle(Color(white: 0.15))
        .padding(.horizontal, 12)
        .frame(height: 56)
        .background(Color.white.ignoresSafeArea(edges: .top))
        .contentShape(Rectangle())
        .onTapGesture { /* 栏内空白不触发页面的显隐手势。 */ }
        .accessibilityIdentifier("diary.topBar")
    }
}

struct DiaryPageBottomBar: View {
    let isBookmarked: Bool
    let onAction: (DiaryPageAction) -> Void

    var body: some View {
        HStack(spacing: 0) {
            ForEach(DiaryPageAction.allCases) { action in
                let isSelected = action == .bookmark && isBookmarked

                Button {
                    onAction(action)
                } label: {
                    VStack(spacing: 6) {
                        Image(systemName: isSelected ? "bookmark.fill" : action.systemImage)
                            .font(.system(size: 22, weight: .medium))
                            .frame(height: 26)

                        Text(isSelected ? "已收藏" : action.rawValue)
                            .font(.system(size: 12))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .foregroundStyle(isSelected ? Color.orange : Color(white: 0.15))
                    .frame(maxWidth: .infinity, minHeight: 56)
                    .contentShape(Rectangle())
                }
                .accessibilityLabel(isSelected ? "取消收藏" : action.rawValue)
            }
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        .contentShape(Rectangle())
        .onTapGesture { /* 操作栏接收点击，不将点击传给下方内页。 */ }
        .accessibilityIdentifier("diary.bottomBar")
    }
}
