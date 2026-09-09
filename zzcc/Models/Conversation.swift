import Foundation

struct Conversation: Identifiable {
    let id = UUID()
    let name: String
    let preview: String
    let time: String
    let avatar: String
    let unreadCount: Int
    let isCurrentDevice: Bool
}
