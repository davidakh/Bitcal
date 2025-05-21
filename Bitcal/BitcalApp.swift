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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(historyManager)
        }
    }
}
