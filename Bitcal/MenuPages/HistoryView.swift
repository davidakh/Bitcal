//
//  HistoryView.swift
//  Bitcal
//
//  Created by David Akhmdbayev on 5/21/25.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var historyManager: HistoryManager

    var body: some View {
        NavigationStack {
            VStack {
                historyNavBar()
                if historyManager.history.isEmpty {
                    Spacer()
                    Image(systemName: "clock")
                        .font(.system(size: 64, weight: .medium))
                        .foregroundStyle(.gray)
                    Text("No History")
                        .foregroundStyle(.gray)
                        .font(.system(size: 24, weight: .medium, design: .monospaced))
                    Spacer()
                } else {
                    List {
                        ForEach(historyManager.history) { entry in
                            VStack(alignment: .leading, spacing: 2) {
                                Text(entry.expression)
                                    .font(.system(size: 14))
                                    .foregroundStyle(.gray)

                                Text("= \(entry.result)")
                                    .font(.system(size: 16, weight: .medium, design: .monospaced))
                                    .foregroundStyle(.main)
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: deleteHistoryItem)
                    }
                }
            }
            .background(Color(.systemGray6))
        }
    }

    @ViewBuilder
    private func historyNavBar() -> some View {
        HStack(spacing: 12) {
            Text("History")
                .font(.system(size: 18, weight: .semibold, design: .monospaced))
                .foregroundStyle(.main)

            Spacer()

            Button(action: {
                triggerHeavyHaptic()
                historyManager.clearHistory()
            }) {
                Image(systemName: "trash")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.red)
                    .frame(width: 32, height: 32)
                    .background(Color(.systemGray5))
                    .clipShape(Capsule())
            }

            Button(action: {
                triggerLightHaptic()
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.main)
                    .frame(width: 32, height: 32)
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .background(Color(.systemGray6))
    }

    private func deleteHistoryItem(at offsets: IndexSet) {
        historyManager.history.remove(atOffsets: offsets)
    }

    private func triggerHeavyHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }

    private func triggerLightHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

#Preview {
    HistoryView().environmentObject(HistoryManager())
}
