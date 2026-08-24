//
//  ContentView.swift
//  zzcc
//
//  Created by 朱梓榕 on 2026/8/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PlaceholderTabView(
                title: "首页",
                message: "首页功能待开发",
                systemImage: "sparkles"
            )
            .tabItem {
                Label("首页", systemImage: "sparkles")
            }

            PlaceholderTabView(
                title: "日程",
                message: "日程功能待开发",
                systemImage: "calendar"
            )
            .tabItem {
                Label("日程", systemImage: "calendar")
            }

            ChatListView()
                .tabItem {
                    Label("对话", systemImage: "message")
                }

            PlaceholderTabView(
                title: "我的",
                message: "个人中心待开发",
                systemImage: "person"
            )
            .tabItem {
                Label("我的", systemImage: "person")
            }
        }
        .tint(.orange)
    }
}

private struct PlaceholderTabView: View {
    let title: String
    let message: String
    let systemImage: String

    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                message,
                systemImage: systemImage
            )
            .navigationTitle(title)
        }
    }
}

#Preview {
    ContentView()
}
