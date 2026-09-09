import SwiftUI

/// 日记主视觉和打开后的内页占位。
struct DiaryBookStage: View {
    let isOpen: Bool
    let isOpening: Bool

    var body: some View {
        ZStack {
            if isOpen {
                openBook
                    .transition(.opacity.combined(with: .scale(scale: 0.92)))
            } else {
                closedBook
                    .transition(.opacity.combined(with: .scale(scale: 0.92)))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.easeInOut(duration: 0.36), value: isOpen)
        .animation(.easeIn(duration: 1.2), value: isOpening)
    }

    private var closedBook: some View {
        Image("diaryBookCover")
            .resizable()
            .scaledToFit()
            // JSON 翻书动画开始时，主视觉从 100% 加速淡出到 0%。
            .opacity(isOpening ? 0 : 1)
            .accessibilityHidden(true)
    }

    private var openBook: some View {
        HStack(spacing: 0) {
            page
            page
        }
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay {
            Rectangle()
                .fill(Color.black.opacity(0.08))
                .frame(width: 1)
        }
    }

    private var page: some View {
        Rectangle()
            .fill(Color(red: 0.995, green: 0.985, blue: 0.95))
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 12) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.black.opacity(0.12))
                        .frame(width: 66, height: 6)
                    ForEach(0..<5, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.black.opacity(0.08))
                            .frame(height: 5)
                    }
                }
            .padding(24)
            }
    }
}
