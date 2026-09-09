import Foundation

struct Message: Identifiable {
    let id = UUID()
    let content: String
    let isFromMe: Bool
    let senderAvatar: String?
    let timestamp: String?
}
