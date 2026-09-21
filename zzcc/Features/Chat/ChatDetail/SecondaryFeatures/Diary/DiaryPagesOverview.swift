import SwiftUI

/// 预览当前日记的所有内页，点击缩略图定位到对应页。
struct DiaryPagesOverview: View {
    let pages: [String]
    let selectedPage: Int
    let onSelect: (Int) -> Void

    private let columns = [GridItem(.adaptive(minimum: 140), spacing: 16)]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(pages.indices, id: \.self) { index in
                    Button {
                        onSelect(index)
                    } label: {
                        VStack(spacing: 8) {
                            Image(pages[index])
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(
                                            index == selectedPage ? Color.orange : .clear,
                                            lineWidth: 3
                                        )
                                }

                            HStack(spacing: 4) {
                                Text("第 \(index + 1) 页")
                                if index == selectedPage {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.orange)
                                }
                            }
                            .font(.subheadline)
                            .foregroundStyle(.primary)
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("第 \(index + 1) 页\(index == selectedPage ? "，当前页" : "")")
                    .accessibilityHint("打开这一页日记")
                }
            }
            .padding(20)
        }
        .navigationTitle("全部笔记")
    }
}
