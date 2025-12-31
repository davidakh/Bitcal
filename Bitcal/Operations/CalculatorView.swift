//
//  CalculatorView.swift
//  Bitcal
//
//  Created by David Akhmdbayev on 5/21/25.
//

import SwiftUI

struct CalculatorView: View {
    @EnvironmentObject var historyManager: HistoryManager

    @Binding var currentInput: String
    @Binding var selectedBase: NumberBase

    @State private var currentOperator: String = ""
    @State private var runningTotal: String = ""
    @State private var fullExpression: String = ""
    @State private var isOperatorJustSet = false
    @State private var decimalDisplay: String = ""

    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            VStack(spacing: 4) {
                if !decimalDisplay.isEmpty {
                    Text(fullExpression)
                        .font(.system(size: 14, weight: .regular, design: .monospaced))
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 16)
                } else if !fullExpression.isEmpty || !currentInput.isEmpty {
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

                    Text(decimalDisplay.isEmpty ? currentInput : decimalDisplay)
                        .font(.system(size: 48, weight: .semibold, design: .monospaced))
                        .foregroundStyle(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 16)
            }
            Spacer()
            VStack(spacing: 12) {
                operationsRow()
                    .frame(height: 48)
                
                if selectedBase == .binary {
                    BinaryKeyboard(input: $currentInput, equalsAction: evaluate)
                        .frame(height: 360)
                } else if selectedBase == .decimal {
                    DecimalKeyboard(input: $currentInput, equalsAction: evaluate)
                        .frame(height: 360)
                } else {
                    HexKeyboard(input: $currentInput, equalsAction: evaluate)
                        .frame(height: 360)
                }
            }
        }
    }

    @ViewBuilder
    private func operationsRow() -> some View {
        HStack(spacing: 12) {
            ForEach(["÷", "×", "+", "-"], id: \.self) { symbol in
                Button(action: {
                    triggerHapticFeedback()
                    handleOperatorPress(symbol)
                }) {
                    ZStack {
                        Capsule()
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .foregroundStyle(Color(.systemGray6))
                        Text(symbol)
                            .font(.system(size: 32, weight: .semibold))
                            .foregroundStyle(.main)
                            .padding(.bottom, 4)
                    }
                }
            }
        }
    }

    private func handleOperatorPress(_ symbol: String) {
        if !runningTotal.isEmpty && !currentInput.isEmpty {
            runningTotal = Logic.evaluate(a: runningTotal, b: currentInput, op: currentOperator, base: selectedBase)
            fullExpression += " \(currentInput) \(symbol)"
        } else if runningTotal.isEmpty && !currentInput.isEmpty {
            runningTotal = currentInput
            fullExpression = "\(currentInput) \(symbol)"
        }

        currentOperator = symbol
        currentInput = ""
        decimalDisplay = ""
        isOperatorJustSet = true
    }

    private func evaluate() {
        triggerHapticFeedback()
        guard !runningTotal.isEmpty, !currentInput.isEmpty, !currentOperator.isEmpty else { return }

        let result = Logic.evaluate(a: runningTotal, b: currentInput, op: currentOperator, base: selectedBase)

        historyManager.addEntry(expression: "\(runningTotal) \(currentOperator) \(currentInput)", result: result)

        currentInput = result
        runningTotal = ""
        currentOperator = ""
        fullExpression = ""
        decimalDisplay = ""
        isOperatorJustSet = false
    }

    private func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
} 

extension NumberBase {
    var digits: [String] {
        switch self {
        case .binary: return ["0", "1"]
        case .decimal: return (0...9).map { String($0) }
        case .hexadecimal: return (0...15).map { String($0, radix: 16).uppercased() }
        }
    }

    var keyboardRows: [[String]] {
        switch self {
        case .binary:
            return [["0", "1"]]
        case .decimal:
            return [["7", "8", "9"], ["4", "5", "6"], ["1", "2", "3"], ["0"]]
        case .hexadecimal:
            return [["7", "8", "9"], ["4", "5", "6"], ["1", "2", "3"], ["0", "A", "B"], ["C", "D", "E", "F"]]
        }
    }
}

extension Logic {
    static func evaluate(a: String, b: String, op: String, base: NumberBase) -> String {
        guard let aInt = Int(a, radix: base.radix),
              let bInt = Int(b, radix: base.radix) else {
            return "0"
        }

        let result: Int
        switch op {
        case "+": result = aInt + bInt
        case "-": result = aInt - bInt
        case "×": result = aInt * bInt
        case "÷": result = bInt != 0 ? aInt / bInt : 0
        default: return "0"
        }

        return String(result, radix: base.radix).uppercased()
    }
}

#Preview {
    CalculatorView(
        currentInput: .constant("0101"),
        selectedBase: .constant(.binary)
    )
    .environmentObject(HistoryManager())
}
