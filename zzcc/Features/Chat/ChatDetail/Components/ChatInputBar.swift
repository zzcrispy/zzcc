import SwiftUI

struct ChatInputBar: View {
    @Binding var inputText: String
    @Binding var isExpanded: Bool
    let onActionSelected: (ChatSecondaryDestination) -> Void

    // A single spring drives the input row, grid, and container height together.
    private let expandAnimation = Animation.spring(response: 0.34, dampingFraction: 0.86)

    var body: some View {
        VStack(spacing: 0) {
            Divider()

            HStack(spacing: 12) {
                TextField("发送消息", text: $inputText)
                    .font(.system(size: 15))
                    .padding(.horizontal, 14)
                    .frame(height: 40)
                    .background(Color(uiColor: .systemGray6), in: Capsule())

                Button("表情", systemImage: "face.smiling") { }
                    .labelStyle(.iconOnly)
                    .font(.system(size: 24))
                    .foregroundStyle(.primary)

                Button {
                    withAnimation(expandAnimation) {
                        isExpanded.toggle()
                    }
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 24))
                        .foregroundStyle(.primary)
                }
                .accessibilityLabel(isExpanded ? "收起功能" : "展开功能")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)

            if isExpanded {
                Divider()

                // Keep both rows in the layout from the start. LazyVGrid can
                // create the second row during the spring, which makes the
                // final two actions appear to jump.
                VStack(spacing: 18) {
                    actionRow(startingAt: 0)
                    actionRow(startingAt: 4)
                }
                .padding(.horizontal, 16)
                .padding(.top, 14)
                .padding(.bottom, 10)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .background(Color(uiColor: .systemBackground))
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: -3)
    }

    @ViewBuilder
    private func actionRow(startingAt start: Int) -> some View {
        HStack(spacing: 16) {
            ForEach(0..<4, id: \.self) { offset in
                let index = start + offset
                if index < ChatSecondaryDestination.allCases.count {
                    actionCell(for: ChatSecondaryDestination.allCases[index])
                } else {
                    // Keep empty columns in the second row so future actions
                    // can be added without changing existing alignment.
                    Color.clear
                        .frame(maxWidth: .infinity)
                        .frame(height: 79)
                }
            }
        }
    }

    @ViewBuilder
    private func actionCell(for destination: ChatSecondaryDestination) -> some View {
        Button {
            onActionSelected(destination)
        } label: {
            VStack(spacing: 7) {
                Image(systemName: destination.systemImage)
                    .font(.system(size: 22))
                    .foregroundStyle(Color(Color.black))
                    .frame(width: 58, height: 58)
                    .background(.white, in: RoundedRectangle(cornerRadius: 12))
                    .shadow(color: .black.opacity(0.02), radius: 6, x: 0, y: 1)


                Text(destination.rawValue)
                    .font(.system(size: 12))
                    .foregroundStyle(Color(Color.black))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
        .frame(minHeight: 79, alignment: .top)
    }
}
