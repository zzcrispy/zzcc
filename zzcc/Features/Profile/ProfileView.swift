// Features/Profile/ProfileView.swift

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 14) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(.orange)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("AMBY 用户")
                                .font(.headline)

                            Text("已连接 1 台设备")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }

                Section("设备") {
                    Label("我的设备", systemImage: "hifispeaker.fill")
                    Label("添加设备", systemImage: "plus.circle")
                }

                Section("角色") {
                    Label("我创建的角色", systemImage: "person.3")
                }

                Section("支持与关于") {
                    Label("问题反馈", systemImage: "questionmark.circle")
                    Label("条款与协议", systemImage: "doc.text")
                    Label("关于我们", systemImage: "info.circle")
                }
            }
            .navigationTitle("我的")
        }
    }
}
