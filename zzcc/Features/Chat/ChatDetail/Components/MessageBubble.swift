import SwiftUI

struct MessageBubble: View {
    let content: String
    let isFromMe: Bool

    var body: some View {
        Text(content)
            .font(.system(size: 15))
            .foregroundStyle(
                isFromMe
                    ? .black
                    : Color(red: 0.13, green: 0.13, blue: 0.13)
            )
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(
                isFromMe
                    ? Color(
                        red: 254.0 / 255.0,
                        green: 220.0 / 255.0,
                        blue: 133.0 / 255.0
                    )
                    : .white,
                in: RoundedRectangle(
                    cornerRadius: 12,
                    style: .continuous
                )
            )
            .shadow(
                color: .black.opacity(0.05),
                radius: 2,
                x: 0,
                y: 1
            )
    }
}
