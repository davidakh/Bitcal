//
//  CalculatorView.swift
//  Bitcal
//
//  Created by David Akhmdbayev on 5/21/25.
//

import SwiftUI

struct CalculatorView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @EnvironmentObject var historyManager: HistoryManager
    @Binding var currentInput: String
    @State private var currentOperator: String = ""
    @State private var runningTotal: String = ""
    @State private var fullExpression: String = ""
    @State private var isOperatorJustSet = false

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 4) {
                if !fullExpression.isEmpty || !currentInput.isEmpty {
                    Text(fullExpression + (currentInput.isEmpty ? "" : " \(currentInput)"))
                        .font(.system(size: 14, weight: .regular, design: .monospaced))
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 16)
                }

                ZStack(alignment: .center) {
                    Text("0000000000")
                        .font(.system(size: 48, weight: .semibold, design: .monospaced))
                        .opacity(0)

                    Text(currentInput)
                        .font(.system(size: 48, weight: .semibold, design: .monospaced))
                        .foregroundStyle(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 16)
            }
            Spacer()
            keyboard()
        }
    }

    @ViewBuilder
    private func keyboard() -> some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Button(action: {
                    triggerHapticFeedback()
                    if !currentInput.isEmpty {
                        currentInput.removeLast()
                    }
                }) {
                    ZStack {
                        Capsule()
                            .frame(width: .infinity, height: 100)
                            .foregroundStyle(Color(.systemGray6))
                        Image(systemName: "delete.left.fill")
                            .font(.system(size: 36, weight: .semibold))
                            .foregroundStyle(.accent)
                            .padding(.trailing, 6)
                    }
                }
                .simultaneousGesture(
                    LongPressGesture(minimumDuration: 0.6).onEnded { _ in
                        triggerHapticFeedback()
                        currentInput = ""
                        runningTotal = ""
                        currentOperator = ""
                        fullExpression = ""
                        isOperatorJustSet = false
                    }
                )

                // + Button
                Button(action: {
                    triggerHapticFeedback()
                    handleOperatorPress("+")
                }) {
                    ZStack {
                        buttonBackground()
                        Text("+")
                            .font(.system(size: 64, weight: .semibold))
                            .foregroundStyle(.main)
                            .padding(.bottom, 6)
                    }
                }

                // - Button
                Button(action: {
                    triggerHapticFeedback()
                    handleOperatorPress("-")
                }) {
                    ZStack {
                        buttonBackground()
                        Text("-")
                            .font(.system(size: 64, weight: .semibold))
                            .foregroundStyle(.main)
                            .padding(.bottom, 5)
                    }
                }
            }

            // Binary input buttons
            HStack {
                binaryButton("0")
                Divider()
                binaryButton("1")
            }
            .padding(.horizontal, 8)
            .background(Color(.systemGray6))
            .clipShape(Capsule())

            // = Button
            Button(action: {
                triggerHapticFeedback()
                guard !runningTotal.isEmpty, !currentInput.isEmpty, !currentOperator.isEmpty else { return }

                var result = ""
                switch currentOperator {
                case "+": result = Logic.add(runningTotal, currentInput)
                case "-": result = Logic.subtract(runningTotal, currentInput)
                default: return
                }

                let expression = fullExpression + " " + currentInput
                historyManager.addEntry(expression: expression, result: result)

                currentInput = result
                runningTotal = ""
                currentOperator = ""
                fullExpression = ""
                isOperatorJustSet = false
            }) {
                ZStack {
                    Capsule()
                        .frame(width: .infinity, height: 100)
                        .foregroundStyle(.accent)
                    Text("=")
                        .font(.system(size: 64, weight: .semibold, design: .monospaced))
                        .foregroundStyle(.black)
                }
            }
        }
        .frame(height: 460)
    }

    private func binaryButton(_ bit: String) -> some View {
        Button(action: {
            triggerHapticFeedback()
            if isOperatorJustSet {
                currentInput = ""
                isOperatorJustSet = false
            }
            currentInput.append(bit)
        }) {
            HStack {
                Spacer()
                Text(bit)
                    .font(.system(size: 64, weight: .semibold, design: .monospaced))
                    .foregroundStyle(.main)
                Spacer()
            }
            .background(Color(.systemGray6))
        }
    }

    private func buttonBackground() -> some View {
        Group {
            if UIDevice.current.userInterfaceIdiom == .pad {
                Capsule()
                    .frame(width: .infinity, height: 100)
                    .foregroundStyle(Color(.systemGray6))
            } else {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Color(.systemGray6))
            }
        }
    }

    private func handleOperatorPress(_ symbol: String) {
        if !runningTotal.isEmpty && !currentInput.isEmpty {
            switch currentOperator {
            case "+": runningTotal = Logic.add(runningTotal, currentInput)
            case "-": runningTotal = Logic.subtract(runningTotal, currentInput)
            default: break
            }
            fullExpression += " \(currentInput) \(symbol)"
        } else if runningTotal.isEmpty && !currentInput.isEmpty {
            runningTotal = currentInput
            fullExpression = currentInput + " \(symbol)"
        }
        currentOperator = symbol
        currentInput = ""
        isOperatorJustSet = true
    }

    func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

#Preview {
    CalculatorView(currentInput: .constant("0101"))
        .environmentObject(HistoryManager())
}
