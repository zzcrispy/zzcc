import SwiftUI

struct ChatDetailView: View {
    let contactName: String
    let avatarName: String

    @State private var inputText = ""
    @State private var isActionBarExpanded = false
    @State private var selectedDestination: ChatSecondaryDestination?

    private var messages: [Message] {
        [
            Message(content: "你的小青蛙们刚刚忘记还给你了，还在我这", isFromMe: false, senderAvatar: avatarName, timestamp: "昨天 21:24"),
            Message(content: "我看老板根本就是骗人的！抽奖箱里肯定全是谢谢参与", isFromMe: true, senderAvatar: nil, timestamp: nil),
            Message(content: "应该不是的，因为后来我不小心抽到了一等奖...我记得你当时看起来也挺喜欢老板安慰你送的小青蛙", isFromMe: false, senderAvatar: avatarName, timestamp: nil),
            Message(content: "当时看起来也挺喜欢老板安慰你送的小青蛙", isFromMe: false, senderAvatar: nil, timestamp: nil),
            Message(content: "你当时看起来也挺喜欢老板安慰", isFromMe: false, senderAvatar: nil, timestamp: nil)
        ]
    }

    init(contactName: String = "小鱼", avatarName: String = "xiaoyu") {
        self.contactName = contactName
        self.avatarName = avatarName
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 0) {
                    if let timestamp = messages.first?.timestamp {
                        Text(timestamp)
                            .font(.system(size: 12))
                            .foregroundStyle(.secondary)
                            .padding(.top, 20)
                            .padding(.bottom, 16)
                    }

                    ForEach(messages) { message in
                        MessageRow(message: message)
                            .padding(.bottom, 12)
                    }
                }
                .padding(.horizontal, 16)
            }
            .background(Color(uiColor: .systemGroupedBackground))

            ChatInputBar(
                inputText: $inputText,
                isExpanded: $isActionBarExpanded,
                onActionSelected: { destination in
                    isActionBarExpanded = false
                    selectedDestination = destination
                }
            )
        }
        .navigationTitle(contactName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbarColorScheme(.light, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("更多选项", systemImage: "ellipsis") {
                }
                .labelStyle(.iconOnly)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationDestination(item: $selectedDestination) { destination in
            secondaryFeatureView(for: destination)
        }
    }

    @ViewBuilder
    private func secondaryFeatureView(for destination: ChatSecondaryDestination) -> some View {
        switch destination {
        case .photos: PhotosView()
        case .camera: CameraView()
        case .diary: DiaryView()
        case .search: ChatSearchView()
        case .topics: InspirationTopicsView()
        case .collection: AmberCollectionView()
        }
    }
}

#Preview {
    NavigationStack {
        ChatDetailView()
    }
}
