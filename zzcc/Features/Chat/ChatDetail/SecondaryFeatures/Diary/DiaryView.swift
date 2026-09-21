import SwiftUI

/// 小日记首页的交互骨架。
///
/// 点击主视觉进入阅读层，由阅读层完成翻书和内页渐显；返回使用原生右滑。
struct DiaryView: View {
    @State private var isReading = false
    @State private var isOpeningReader = false

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
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(DiaryTheme.background, for: .navigationBar)
        // 封面使用系统导航栏；内页在自己的导航层级中隐藏它。
        .toolbar(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("日记形象", systemImage: "square.grid.2x2") { }
                    .labelStyle(.iconOnly)
                    .accessibilityLabel("日记形象")
            }
        }
        .navigationDestination(isPresented: $isReading) {
            DiaryReaderView(onClose: closeBook) {
                isOpeningReader = false
            }
            .toolbar(.hidden, for: .navigationBar)
            .toolbar(.hidden, for: .tabBar)
            .statusBarHidden(false)
        }
        .transaction { transaction in
            // 仅关闭进入阅读层的系统推入转场，不影响阅读完成后的原生右滑返回。
            if isReading && isOpeningReader {
                transaction.animation = nil
                transaction.disablesAnimations = true
            }
        }
    }

    private var bookStage: some View {
        Button {
            openBook()
        } label: {
            ZStack {
                DiaryBookStage()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 560)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(isReading)
        .accessibilityLabel("打开小日记")
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
        guard !isReading else { return }

        // 先无动画进入阅读层，在同一层里播放 JSON 并渐显内页。
        // 动画结束时不再切换导航层级，避免内页突然出现或尺寸跳变。
        var transaction = Transaction(animation: nil)
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            isOpeningReader = true
            isReading = true
        }
    }

    private func closeBook() {
        guard isReading else { return }

        // 原生导航 pop：内页从左向右滑出，封面从后方露出。
        // 不改变透明度、不缩放，也不额外添加与左右翻页竞争的拖动手势。
        withAnimation(.default) {
            isReading = false
        }
    }
}

enum DiaryTheme {
    static let pageBackground = Color(red: 1.0, green: 246.0 / 255.0, blue: 239.0 / 255.0) // #FFF6EF
    static let background = Color(red: 0.96, green: 0.945, blue: 0.925)
    static let secondaryText = Color.black.opacity(0.48)
    static let profileCard = Color(red: 0.58, green: 0.53, blue: 0.48).opacity(0.66)
}

#Preview {
    NavigationStack {
        DiaryView()
    }
}
