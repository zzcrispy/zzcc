// Features/Home/HomeView.swift

import SwiftUI

struct HomeView: View {
    private let agents = [
        Agent(name: "小安", description: "陪伴你安排日常，也记得你的偏好。", symbol: "sun.max.fill", color: .orange),
        Agent(name: "小星", description: "适合聊天、记录灵感与情绪。", symbol: "star.fill", color: .purple),
        Agent(name: "小森", description: "陪你专注工作，提醒重要事项。", symbol: "leaf.fill", color: .green)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("智能体广场")
                            .font(.largeTitle.bold())

                        Text("发现适合你的陪伴角色")
                            .foregroundStyle(.secondary)
                    }

                    VStack(spacing: 12) {
                        ForEach(agents) { agent in
                            AgentRow(agent: agent)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("AMBY")
        }
    }
}

private struct AgentRow: View {
    let agent: Agent

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: agent.symbol)
                .font(.title2)
                .foregroundStyle(.white)
                .frame(width: 52, height: 52)
                .background(agent.color, in: RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 5) {
                Text(agent.name)
                    .font(.headline)

                Text(agent.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(14)
        .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 14))
    }
}
