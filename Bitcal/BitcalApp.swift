//
//  BitcalApp.swift
//  Bitcal
//
//  Created by David Akhmdbayev on 5/20/25.
//

import SwiftUI

@main
struct BitcalApp: App {
    @StateObject var historyManager = HistoryManager()
    @AppStorage("hasSeenWelcomeScreen") var hasSeenWelcomeScreen: Bool = false
    @AppStorage("hasSeenUpdateScreen") var hasSeenUpdateScreen: Bool = false
    @State private var selectedBase: NumberBase = loadDefaultNumberBase()

    var body: some Scene {
        WindowGroup {
            ContentView(selectedBase: $selectedBase) // ✅ Pass binding
                .environmentObject(historyManager)
                .sheet(isPresented: .constant(!hasSeenWelcomeScreen)) {
                    WelcomeView()
                        .presentationCornerRadius(32)
                        .presentationDragIndicator(.visible)
                        .interactiveDismissDisabled()
                }
        }
    }
}
