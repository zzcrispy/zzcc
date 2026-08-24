// Features/Schedule/ScheduleView.swift

import SwiftUI

struct ScheduleView: View {
    @State private var reminders = [
        Reminder(title: "喝水", time: "10:30", isEnabled: true),
        Reminder(title: "下午会议", time: "14:00", isEnabled: true),
        Reminder(title: "散步放松", time: "18:30", isEnabled: false)
    ]

    var body: some View {
        NavigationStack {
            List {
                Section("今日提醒") {
                    ForEach($reminders) { $reminder in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(reminder.title)

                                Text(reminder.time)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            Toggle("", isOn: $reminder.isEnabled)
                                .labelsHidden()
                        }
                    }
                }

                Section {
                    Button {
                    } label: {
                        Label("添加提醒", systemImage: "plus.circle.fill")
                    }
                }
            }
            .navigationTitle("日程")
        }
    }
}
