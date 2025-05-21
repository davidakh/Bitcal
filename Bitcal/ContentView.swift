//
//  ContentView.swift
//  Bitcal
//
//  Created by David Akhmdbayev on 5/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isOperationsMenuPresent = false
    @State private var isCalculatorViewPresent = true
    
    var body: some View {
        NavigationStack {
            VStack {
                navBar()
                if isCalculatorViewPresent {
                    CalculatorView()
                        .transition(.blurReplace)
                } else {
                    ConverterView()
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .overlay(alignment: .topLeading) {
                if isOperationsMenuPresent {
                    operationsMenu()
                        .padding(.top, 48)
                        .padding(.leading, 12)
                        .transition(.blurReplace)
                }
            }
        }
    }
    
    @ViewBuilder
    private func navBar() -> some View {
        HStack {
            Button(action: {
                triggerHapticFeedback()
                withAnimation {
                    isOperationsMenuPresent.toggle()
                }
            }) {
                operationSelector()
            }
            Spacer()
            menuButton()
        }
    }
    
    @ViewBuilder
    private func operationSelector() -> some View {
        HStack {
            if isCalculatorViewPresent {
                CalculatorIcon()
                    .foregroundStyle(.main)
                    .frame(width: 20, height: 20)
            } else {
                Image(systemName: "square.fill.on.square")
                    .foregroundStyle(.main)
                    .font(.system(size: 16))
                    .frame(width: 20, height: 20)
            }
            Text(isCalculatorViewPresent ? "Calculator" : "Coverter")
                .font(.system(size: 16, weight: .medium, design: .monospaced))
                .foregroundStyle(.primary)
                .transition(.blurReplace)
            if isOperationsMenuPresent {
                Image(systemName: "chevron.up")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.gray)
                    .transition(.blurReplace)
            } else {
                Image(systemName: "chevron.down")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.gray)
            }
        }
        .padding(.horizontal, 12)
        .frame(height: 32)
        .background(Color(.systemGray6))
        .clipShape(Capsule())
    }
    
    @ViewBuilder
    private func menuButton() -> some View {
        Image(systemName: "ellipsis")
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(.primary)
            .frame(width: 32, height: 32)
            .background(Color(.systemGray6))
            .clipShape(Circle())
    }
    
    @ViewBuilder
    private func operationsMenu() -> some View {
        VStack {
            Button(action: {
                triggerHapticFeedback()
                withAnimation {
                    isCalculatorViewPresent = true
                }
            }) {
                HStack {
                    CalculatorIcon()
                        .font(.system(size: 18))
                        .frame(width: 24, height: 24)
                    Text("Calculator")
                        .font(.system(size: 16, weight: .medium, design: .monospaced))
                }
                .padding(.horizontal, 16)
                .frame(width: 220, height: 48, alignment: .leading)
                    .foregroundStyle(isCalculatorViewPresent ? .main : .accent)
            }
            Divider()
                .frame(width: 220)
            Button(action: {
                triggerHapticFeedback()
                withAnimation {
                    isCalculatorViewPresent = false
                }
            }) {
                MenuItem(symbol: "square.fill.on.square", text: "Converter")
                    .foregroundStyle(isCalculatorViewPresent ? .accent : .main)
            }
        }
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
    
    func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

#Preview {
    ContentView()
}
