// ChatListView.swift

import SwiftUI

struct ChatListView: View {
    private let conversations = [
        Conversation(
            name: "小鱼",
            preview: "刚刚在露台看风景，结果看到楼下伸出来的...",
            time: "5分钟前",
            avatar: "fish",
            unreadCount: 1,
            isCurrentDevice: true
        ),
        Conversation(
            name: "工藤新一",
            preview: "刚刚在露台看风景，结果看到楼下伸出来的...",
            time: "昨天15:13",
            avatar: "detective",
            unreadCount: 0,
            isCurrentDevice: false
        ),
        Conversation(
            name: "秦彻",
            preview: "刚刚在露台看风景，结果看到楼下伸出来的...",
            time: "5月10日",
            avatar: "man",
            unreadCount: 0,
            isCurrentDevice: false
        ),
        Conversation(
            name: "彻子",
            preview: "刚刚在露台看风景，结果看到楼下伸出来的...",
            time: "3月10日",
            avatar: "girl",
            unreadCount: 0,
            isCurrentDevice: false
        )
    ]

    var body: some View {
        NavigationStack {
            List(conversations) { conversation in
                NavigationLink {
                    ChatView(contactName: conversation.name)
                } label: {
                    ConversationRow(conversation: conversation)
                }
            }
            .listStyle(.plain)
            .navigationTitle("聊天")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("切换当前设备角色", systemImage: "arrow.triangle.2.circlepath") {
                    }
                    .labelStyle(.iconOnly)
                }
            }
        }
    }
}

private struct Conversation: Identifiable {
    let id = UUID()
    let name: String
    let preview: String
    let time: String
    let avatar: String
    let unreadCount: Int
    let isCurrentDevice: Bool
}

private struct ConversationRow: View {
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
                            .background(
                                Color.gray.opacity(0.15),
                                in: RoundedRectangle(cornerRadius: 5)
                            )
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
                    .overlay {
                        Circle()
                            .stroke(.background, lineWidth: 1.5)
                    }
                    .offset(x: 3, y: -3)
            }
        }
        .frame(width: 54, height: 54)
    }
}

#Preview {
    ChatListView()
}
