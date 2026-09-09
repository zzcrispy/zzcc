import SwiftUI

enum ChatSecondaryDestination: String, CaseIterable, Identifiable {
    case photos = "照片"
    case camera = "拍摄"
    case search = "查找聊天内容"
    case diary = "小日记"
    case topics = "灵感话题"
    case collection = "琥珀珍藏"

    var id: Self { self }

    var systemImage: String {
        switch self {
        case .photos: return "photo.on.rectangle"
        case .camera: return "camera"
        case .diary: return "book.closed"
        case .search: return "magnifyingglass"
        case .topics: return "lightbulb"
        case .collection: return "archivebox"
        }
    }
}
