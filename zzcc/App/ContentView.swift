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
            HomeView()
            .tabItem {
                Label("首页", systemImage: "sparkles")
            }

            ChatView()
                .tabItem {
                    Label("对话", systemImage: "message")
                }
            ScheduleView()
            .tabItem {
                Label("日程", systemImage: "calendar")
            }



            ProfileView()
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
