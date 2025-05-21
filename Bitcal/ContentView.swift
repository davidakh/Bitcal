//
//  ContentView.swift
//  Bitcal
//
//  Created by David Akhmdbayev on 5/20/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                navBar()
                Text("Hello World!")
                Spacer()
            }
            .padding(.horizontal, 16)
        }
    }
    
    @ViewBuilder
    private func navBar() -> some View {
        HStack {
            Menu {
                Label("Calculator", systemImage: "plusminus")
                Label("Convert", systemImage: "square.on.square")
            } label: {
                operationSelector()
            }
            Spacer()
            settingsButton()
        }
    }
    
    @ViewBuilder
    private func operationSelector() -> some View {
        HStack {
            Image(systemName: "plusminus")
            Text("Calculator")
                .font(.system(size: 16, weight: .medium, design: .monospaced))
                .foregroundStyle(.black)
            Image(systemName: "chevron.down")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 12)
        .frame(height: 32)
        .background(Color(.systemGray6))
        .clipShape(Capsule())
    }
    
    @ViewBuilder
    private func settingsButton() -> some View {
        Image(systemName: "gear")
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(.primary)
            .frame(width: 32, height: 32)
            .background(Color(.systemGray6))
            .clipShape(Circle())
    }
    
    func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

#Preview {
    ContentView()
}
