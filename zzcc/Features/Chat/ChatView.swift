import SwiftUI

struct ChatView: View {
    private let conversations = [
        Conversation(
            name: "小鱼",
            preview: "刚刚在露台看风景，结果看到楼下伸出来的...",
            time: "5分钟前",
            avatar: "xiaoyu",
            unreadCount: 1,
            isCurrentDevice: true
        ),
        Conversation(
            name: "工藤新一",
            preview: "刚刚在露台看风景，结果看到楼下伸出来的...",
            time: "昨天15:13",
            avatar: "gudongxinyi",
            unreadCount: 0,
            isCurrentDevice: false
        ),
        Conversation(
            name: "秦彻",
            preview: "刚刚在露台看风景，结果看到楼下伸出来的...",
            time: "5月10日",
            avatar: "qinche",
            unreadCount: 0,
            isCurrentDevice: false
        ),
        Conversation(
            name: "彻子",
            preview: "刚刚在露台看风景，结果看到楼下伸出来的...",
            time: "3月10日",
            avatar: "chezi",
            unreadCount: 0,
            isCurrentDevice: false
        )
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Text("聊天")
                        .font(.system(size: 26, weight: .bold))

                    Spacer()

                    Button(
                        "切换当前设备角色",
                        systemImage: "arrow.triangle.2.circlepath"
                    ) {
                    }
                    .labelStyle(.iconOnly)
                }
                .padding(.horizontal, 18)
                .frame(height: 52)

                List(conversations) { conversation in
                    NavigationLink {
                        ChatDetailView(contactName: conversation.name, avatarName: conversation.avatar)
                    } label: {
                        ConversationRow(conversation: conversation)
                    }
                }
                .listStyle(.plain)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
#Preview {
    ChatView()
}
