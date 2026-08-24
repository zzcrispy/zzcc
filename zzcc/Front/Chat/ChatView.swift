// Features/Chat/ChatView.swift

import SwiftUI

struct ChatView: View {
    let contactName: String

    @State private var message = ""

    init(contactName: String = "小鱼") {
        self.contactName = contactName
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 10) {
                    Text("昨天 21:24")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.vertical, 12)

                    ChatBubble(
                        text: "你的小青蛙们刚刚忘记还给你了，还在我这",
                        isCurrentUser: false
                    )

                    ChatBubble(
                        text: "我看老板根本就是骗人的！抽奖箱里肯定全是谢谢参与",
                        isCurrentUser: true
                    )

                    ChatBubble(
                        text: "应该不是的，因为后来我不小心抽到了一等奖...我记得你当时看起来也挺喜欢老板安慰你送的小青蛙",
                        isCurrentUser: false
                    )

                    ChatBubble(
                        text: "当时看起来也挺喜欢老板安慰你送的小青蛙",
                        isCurrentUser: false
                    )

                    ChatBubble(
                        text: "你当时看起来也挺喜欢老板安慰",
                        isCurrentUser: false
                    )
                }
                .padding(.horizontal)
            }
            .background(Color(uiColor: .systemGroupedBackground))

            messageComposer
        }
        .navigationTitle(contactName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("更多选项", systemImage: "ellipsis") {
                }
                .labelStyle(.iconOnly)
            }
        }
    }

    private var messageComposer: some View {
        HStack(spacing: 12) {
            TextField("发送消息", text: $message)
                .textFieldStyle(.plain)
                .padding(.horizontal, 16)
                .frame(height: 40)
                .background(.background, in: Capsule())

            Button("表情", systemImage: "face.smiling") {
            }
            .labelStyle(.iconOnly)
            .font(.title2)
            .foregroundStyle(.primary)

            Button("添加", systemImage: "plus.circle") {
            }
            .labelStyle(.iconOnly)
            .font(.title2)
            .foregroundStyle(.primary)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
    }
}

private struct ChatBubble: View {
    let text: String
    let isCurrentUser: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            if !isCurrentUser {
                Image(systemName: "person.crop.circle.fill")
                    .font(.title)
                    .foregroundStyle(.gray)
            } else {
                Spacer(minLength: 54)
            }

            Text(text)
                .padding(12)
                .foregroundStyle(.primary)
                .background(
                    isCurrentUser
                        ? Color(uiColor: .systemGray5)
                        : Color(uiColor: .systemBackground),
                    in: RoundedRectangle(cornerRadius: 12)
                )

            if !isCurrentUser {
                Spacer(minLength: 54)
            }
        }
        .frame(maxWidth: .infinity, alignment: isCurrentUser ? .trailing : .leading)
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}

