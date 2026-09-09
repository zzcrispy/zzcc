import SwiftUI

struct ChatFeaturePlaceholderView: View {
    let destination: ChatSecondaryDestination

    var body: some View {
        ContentUnavailableView(
            "待开发",
            systemImage: destination.systemImage,
            description: Text("\(destination.rawValue)功能待开发")
        )
        .navigationTitle(destination.rawValue)
        .navigationBarTitleDisplayMode(.inline)
    }
}
