import SwiftUI

/// 小日记首页的交互骨架。
///
/// 默认显示主视觉，点击日记区域后播放一次翻书动画，再进入内页占位。
struct DiaryView: View {
    private enum Phase {
        case idle
        case opening
        case opened
    }

    @State private var phase: Phase = .idle

    private var isBookOpen: Bool {
        phase == .opened
    }

    var body: some View {
        ZStack {
            DiaryTheme.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer(minLength: 8)

                bookStage

                Spacer(minLength: 18)

                diaryProfileSwitcher
            }
            .padding(.horizontal, 24)

            if phase == .opening {
                DiaryAnimationSlot {
                    finishOpening()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
                .zIndex(10)
                .accessibilityHidden(true)
            }

            if phase == .opened {
                DiaryPagesView(onClose: closeBook)
                    .transition(.opacity)
                    .zIndex(5)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(DiaryTheme.background, for: .navigationBar)
        .toolbar(phase == .opening || phase == .opened ? .hidden : .visible, for: .navigationBar)
        .statusBarHidden(phase == .opening || phase == .opened)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("日记形象", systemImage: "square.grid.2x2") { }
                    .labelStyle(.iconOnly)
                    .accessibilityLabel("日记形象")
            }

        }
    }

    private var bookStage: some View {
        Button {
            openBook()
        } label: {
            ZStack {
                DiaryBookStage(
                    isOpen: isBookOpen,
                    isOpening: phase == .opening
                )
            }
            .frame(maxWidth: .infinity)
            .frame(height: 560)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(phase != .idle)
        .accessibilityLabel(isBookOpen ? "日记内页" : "打开小日记")
    }

    private var diaryProfileSwitcher: some View {
        Button { } label: {
            HStack(spacing: 6) {
                Image(systemName: "person.2.fill")
                    .font(.system(size: 20, weight: .medium))
                    .frame(width: 30)

                Text("去更换我与TA的日记形象")
                    .font(.system(size: 16, weight: .medium))
                    .lineLimit(1)

                Spacer(minLength: 8)

                HStack(spacing: -12) {
                    diaryAvatar(named: "xiaoyu")
                    diaryAvatar(named: "gudongxinyi")
                }

                Image(systemName: "chevron.right")
                    .font(.system(size:16, weight: .semibold))
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .frame(height: 50)
            .background(DiaryTheme.profileCard, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
        }
        .buttonStyle(.plain)
        .disabled(false)
        .accessibilityLabel("日记形象待开发")
    }

    private func diaryAvatar(named name: String) -> some View {
        Image(name)
            .resizable()
            .scaledToFill()
            .frame(width: 34, height: 34)
            .clipShape(Circle())
            .overlay(Circle().stroke(.white, lineWidth: 2))
    }

    private func openBook() {
        guard phase == .idle else { return }

        withAnimation(.easeInOut(duration: 0.22)) {
            phase = .opening
        }
    }

    private func finishOpening() {
        guard phase == .opening else { return }

        withAnimation(.easeInOut(duration: 0.36)) {
            phase = .opened
        }
    }

    private func closeBook() {
        withAnimation(.easeInOut(duration: 0.32)) {
            phase = .idle
        }
    }
}

enum DiaryTheme {
    static let background = Color(red: 0.96, green: 0.945, blue: 0.925)
    static let secondaryText = Color.black.opacity(0.48)
    static let profileCard = Color(red: 0.58, green: 0.53, blue: 0.48).opacity(0.66)
}

#Preview {
    NavigationStack {
        DiaryView()
    }
}
