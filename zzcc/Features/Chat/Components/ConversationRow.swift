import SwiftUI

struct ConversationRow: View {
    let conversation: Conversation

    var body: some View {
        HStack(spacing: 14) {
            avatarView

            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 6) {
                    Text(conversation.name)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.primary)

                    if conversation.isCurrentDevice {
                        Text("当前设备")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background(Color.gray.opacity(0.15), in: RoundedRectangle(cornerRadius: 5))
                    }

                    Spacer(minLength: 4)

                    Text(conversation.time)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Text(conversation.preview)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
        }
        .padding(.vertical, 7)
    }

    private var avatarView: some View {
        ZStack(alignment: .topTrailing) {
            Image(conversation.avatar)
                .resizable()
                .scaledToFill()
                .frame(width: 54, height: 54)
                .clipShape(Circle())

            if conversation.unreadCount > 0 {
                Text("\(conversation.unreadCount)")
                    .font(.caption2.bold())
                    .foregroundStyle(.white)
                    .frame(width: 18, height: 18)
                    .background(.red, in: Circle())
                    .overlay { Circle().stroke(.background, lineWidth: 1.5) }
                    .offset(x: 3, y: -3)
            }
        }
        .frame(width: 54, height: 54)
    }
}
