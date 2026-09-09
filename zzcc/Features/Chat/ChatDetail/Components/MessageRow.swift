import SwiftUI

struct MessageRow: View {
    let message: Message

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            if message.isFromMe {
                Spacer(minLength: 60)
                MessageBubble(content: message.content, isFromMe: true)
            } else {
                if let avatar = message.senderAvatar {
                    AvatarView(imageName: avatar)
                } else {
                    Spacer().frame(width: 40)
                }
                MessageBubble(content: message.content, isFromMe: false)
                Spacer(minLength: 60)
            }
        }
    }
}
