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
    @State private var copiedOutput: String = ""
    @State private var isNumberSystemMenuPresent = false
    @Binding var selectedBase: NumberBase

    @AppStorage("hasSeenClearTip") var hasSeenClearTip: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                navBar()
                    .padding(.top, 16)
                if isCalculatorViewPresent {
                    CalculatorView(currentInput: $calculatorInput, selectedBase: $selectedBase)
                        .transition(.blurReplace)
                } else {
                    ConverterView(copiedOutput: $copiedOutput)
                        .transition(.blurReplace)
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .overlay(alignment: .top) {
                if hasSeenClearTip == false && isOperationsMenuPresent == false {
                    clearTipOverlay()
                }
            }
            .overlay(alignment: .topLeading) {
                if isOperationsMenuPresent {
                    operationsMenu()
                        .padding(.top, 60)
                        .padding(.leading, 12)
                        .transition(.blurReplace)
                }
            }
            .overlay(alignment: .topTrailing) {
                if isNumberSystemMenuPresent {
                    numberSystemMenu()
                        .padding(.top, 60)
                        .padding(.trailing, 12)
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
                    isNumberSystemMenuPresent = false
                }
            }) {
                operationSelector()
            }
            Spacer()
            if isCalculatorViewPresent {
                Button(action: {
                    triggerHapticFeedback()
                    withAnimation {
                        isNumberSystemMenuPresent.toggle()
                        isOperationsMenuPresent = false
                    }
                }) {
                    numberSystemSelector()
                }
            }
            Button(action: {
                triggerHapticFeedback()
                
                let stringToCopy = isCalculatorViewPresent ? calculatorInput : copiedOutput
                UIPasteboard.general.string = stringToCopy
                
                withAnimation(.easeInOut(duration: 0.2)) {
                    didCopy = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    didCopy = false
                }
            }) {
                if didCopy {
                    Image(systemName: "checkmark")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.main)
                        .frame(width: 32, height: 32)
                        .glassEffect()
                        .clipShape(Circle())
                        .transition(.blurReplace)
                } else {
                    copyButton()
                        .transition(.blurReplace)
                }
            }
            .animation(.easeInOut, value: calculatorInput)
            if isCalculatorViewPresent {
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
    }

    @ViewBuilder
    private func numberSystemSelector() -> some View {
        HStack {
            Text(selectedBase == .binary ? "01" : selectedBase == .decimal ? "123" : "2DE")
                .foregroundStyle(.accent)
                .font(.system(size: 16, weight: .semibold, design: .monospaced))
            Image(systemName: isNumberSystemMenuPresent ? "chevron.up" : "chevron.down")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 12)
        .frame(height: 32)
        .glassEffect(.regular.interactive())
    }

    @ViewBuilder
    private func numberSystemMenu() -> some View {
        let sortedBases = NumberBase.allCases.sorted {
            $0 == selectedBase ? true : ($1 == selectedBase ? false : true)
        }

        VStack {
            ForEach(Array(sortedBases.enumerated()), id: \.1) { index, base in
                Button(action: {
                    triggerHapticFeedback()
                    withAnimation {
                        selectedBase = base
                        isNumberSystemMenuPresent = false
                    }
                }) {
                    HStack(alignment: .center) {
                        Text(base == .decimal ? "123" : base == .binary ? "01" : "2DE")
                            .font(.system(size: 18, weight: .medium, design: .monospaced))
                            .frame(width: 48, height: 24)
                            .foregroundStyle(base == selectedBase ? .accent : .primary)
                        Text(base.rawValue)
                            .font(.system(size: 16, weight: .medium, design: .monospaced))
                            .foregroundStyle(base == selectedBase ? .accent : .primary)
                    }
                    .padding(.horizontal, 16)
                    .frame(width: 220, height: 48, alignment: .leading)
                }

                if index < sortedBases.count - 1 {
                    Divider().frame(width: 220)
                }
            }
        }
        .padding(.vertical, 8)
        .glassEffect(in: RoundedRectangle(cornerRadius: 24))
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
            Text(isCalculatorViewPresent ? "Calculator" : "Converter")
                .font(.system(size: 16, weight: .medium, design: .monospaced))
                .foregroundStyle(.main)
                .transition(.blurReplace)
            Image(systemName: isOperationsMenuPresent ? "chevron.up" : "chevron.down")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 12)
        .frame(height: 32)
        .glassEffect(.regular.interactive())
    }

    @ViewBuilder
    private func clearTipOverlay() -> some View {
        ZStack {
            HStack {
                Image(systemName: "hand.tap.fill")
                    .foregroundStyle(.accent)
                    .font(.system(size: 32))
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text("How to Clear your Calculator")
                        .font(.system(size: 15, weight: .medium, design: .monospaced))
                    Text("Simply tap and hold on the delete button until you feel a strong vibration. ")
                        .font(.system(size: 14, design: .monospaced))
                        .foregroundStyle(.secondary)
                }
                .frame(width: .infinity)
            }
            .padding(16)
            .glassEffect(in: RoundedRectangle(cornerRadius: 24))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.top, 60)
            .padding(.horizontal, 12)
            .transition(.blurReplace)

            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        hasSeenClearTip.toggle()
                    }
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.main)
                        .frame(width: 24, height: 24)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 22)
        }
    }

    @ViewBuilder
    private func copyButton() -> some View {
        Image(systemName: "document.on.document")
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(.main)
            .frame(width: 32, height: 32)
            .glassEffect()
            .clipShape(Circle())
    }

    @ViewBuilder
    private func historyButton() -> some View {
        Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(.main)
            .frame(width: 32, height: 32)
            .glassEffect()
            .clipShape(Circle())
    }

    @ViewBuilder
    private func operationsMenu() -> some View {
        VStack {
            Button(action: {
                triggerHapticFeedback()
                withAnimation {
                    isCalculatorViewPresent = true
                    isOperationsMenuPresent = false
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
            }
            Divider().frame(width: 220)
            Button(action: {
                triggerHapticFeedback()
                withAnimation {
                    isCalculatorViewPresent = false
                    isOperationsMenuPresent = false
                }
            }) {
                MenuItem(symbol: "square.fill.on.square", text: "Converter")
                    .foregroundStyle(isCalculatorViewPresent ? .main : .accent)
            }
        }
        .padding(.vertical, 8)
        .glassEffect(in: RoundedRectangle(cornerRadius: 24))
    }

    func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

#Preview {
    CalculatorView(
        currentInput: .constant("0101"),
        selectedBase: .constant(.binary)
    )
    .environmentObject(HistoryManager())
}
