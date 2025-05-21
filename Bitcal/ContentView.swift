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
    @State private var isSettingsViewPresent = false
    @State private var isHistoryViewPresent = false
    @State private var calculatorInput: String = ""
    @State private var didCopy = false
    
    var body: some View {
        NavigationStack {
            VStack {
                navBar()
                    .padding(.top, 16)
                if isCalculatorViewPresent {
                    CalculatorView(currentInput: $calculatorInput)
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
                        .padding(.top, 60)
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
            Button(action: {
                triggerHapticFeedback()
                UIPasteboard.general.string = calculatorInput
                withAnimation(.easeInOut(duration: 0.2)) {
                    didCopy = true
                }

                // Reset after 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    didCopy = false
                }
            }) {
                if didCopy {
                    Image(systemName: "checkmark")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.main)
                        .frame(width: 32, height: 32)
                        .background(Color(.systemGray6))
                        .clipShape(Circle())
                } else {
                    copyButton() // your original copy icon
                }
            }
            Button(action: {
                triggerHapticFeedback()
                withAnimation {
                    isOperationsMenuPresent = false
                }
                isHistoryViewPresent.toggle()
            }) {
                historyButton()
                    .sheet(isPresented: $isHistoryViewPresent) {
                        HistoryView()
                            .presentationCornerRadius(32)
                            .presentationDragIndicator(.visible)
                    }
            }
        }
    }
    
    @ViewBuilder
    private func operationSelector() -> some View {
        HStack {
            if isCalculatorViewPresent {
                CalculatorIcon()
                    .foregroundStyle(.accent)
                    .frame(width: 20, height: 20)
            } else {
                Image(systemName: "square.fill.on.square")
                    .foregroundStyle(.accent)
                    .font(.system(size: 16))
                    .frame(width: 20, height: 20)
            }
            Text(isCalculatorViewPresent ? "Calculator" : "Coverter")
                .font(.system(size: 16, weight: .medium, design: .monospaced))
                .foregroundStyle(.main)
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
    private func copyButton() -> some View {
        Image(systemName: "document.on.document")
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(.main)
            .frame(width: 32, height: 32)
            .background(Color(.systemGray6))
            .clipShape(Circle())
    }
    
    @ViewBuilder
    private func historyButton() -> some View {
        Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(.main)
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
                HStack(alignment: .center) {
                    CalculatorIcon()
                        .font(.system(size: 18))
                        .frame(width: 24, height: 24)
                        .foregroundStyle(isCalculatorViewPresent ? .accent : .main)
                    VStack(alignment: .leading) {
                        Text("Calculator")
                            .font(.system(size: 16, weight: .medium, design: .monospaced))
                            .foregroundStyle(isCalculatorViewPresent ? .accent : .main)
                        Text("Simple binary operations")
                            .font(.system(size: 12))
                            .foregroundStyle(isCalculatorViewPresent ? .accent : .gray)
                    }
                }
                .padding(.horizontal, 16)
                .frame(width: 220, height: 48, alignment: .leading)
                .background(Color(.systemGray6))
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
                    .foregroundStyle(isCalculatorViewPresent ? .main : .accent)
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
