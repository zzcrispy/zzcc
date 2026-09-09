// Models/Reminder.swift

import Foundation

struct Reminder: Identifiable {
    let id = UUID()
    let title: String
    let time: String
    var isEnabled: Bool
}
