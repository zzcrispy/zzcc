// Models/Agent.swift

import SwiftUI

struct Agent: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let symbol: String
    let color: Color
}
