//
//  HistoryManager.swift
//  Bitcal
//
//  Created by David Akhmdbayev on 5/21/25.
//

import Foundation

struct Entry: Identifiable, Codable {
    let id: UUID
    let expression: String
    let result: String

    init(id: UUID = UUID(), expression: String, result: String) {
        self.id = id
        self.expression = expression
        self.result = result
    }
}

class HistoryManager: ObservableObject {
    @Published var history: [Entry] = [] {
        didSet {
            saveHistory()
        }
    }

    private let historyKey = "bitcal_history"

    init() {
        loadHistory()
    }

    func addEntry(expression: String, result: String) {
        let entry = Entry(expression: expression, result: result)
        history.insert(entry, at: 0)
    }

    func clearHistory() {
        history.removeAll()
    }

    private func saveHistory() {
        if let encoded = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(encoded, forKey: historyKey)
        }
    }

    private func loadHistory() {
        if let savedData = UserDefaults.standard.data(forKey: historyKey),
           let decoded = try? JSONDecoder().decode([Entry].self, from: savedData) {
            history = decoded
        }
    }
}
