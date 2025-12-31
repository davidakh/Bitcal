//
//  ConverterView.swift
//  Bitcal
//
//  Created by David Akhmdbayev on 5/20/25.
//

import SwiftUI

struct ConverterView: View {
    @State private var inputBase: NumberBase = .binary
    @State private var outputBase: NumberBase = .decimal
    @State private var input: String = ""
    @Binding var copiedOutput: String

    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            ScrollView {
                VStack(alignment: .trailing, spacing: 16) {
                    Spacer()

                    Text(input.isEmpty ? "0" : input)
                        .font(.system(size: 32, weight: .semibold, design: .monospaced))
                        .multilineTextAlignment(.trailing)
                        .foregroundStyle(input.isEmpty ? .tertiary : .primary)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 16)

                    VStack(alignment: .trailing, spacing: -16) {
                        Picker(selection: $inputBase, label:
                                Text(inputBase.rawValue)
                            .font(.system(size: 16, weight: .medium, design: .monospaced))
                            .foregroundColor(.accentColor)
                            .padding(.horizontal, 12)
                            .frame(height: 32)
                            .background(Color(.systemGray6))
                            .clipShape(Capsule())
                        ) {
                            ForEach(NumberBase.allCases) { base in
                                Text(base.rawValue).tag(base)
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: inputBase) {
                            if inputBase == outputBase {
                                outputBase = NumberBase.allCases.first(where: { $0 != inputBase }) ?? .decimal
                            }
                        }

                        converterSeperator()

                        Picker(selection: $outputBase, label:
                                Text(outputBase.rawValue)
                            .font(.system(size: 14, weight: .medium, design: .monospaced))
                            .foregroundColor(.accentColor)
                            .padding(.horizontal, 12)
                            .frame(height: 32)
                            .background(Color(.systemGray6))
                            .clipShape(Capsule())
                        ) {
                            ForEach(NumberBase.allCases) { base in
                                Text(base.rawValue).tag(base)
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: outputBase) {
                            if outputBase == inputBase {
                                inputBase = NumberBase.allCases.first(where: { $0 != outputBase }) ?? .binary
                            }
                        }
                    }

                    let output = Logic.convert(input, fromBase: inputBase.radix, toBase: outputBase.radix)
                    Text(output)
                        .font(.system(size: 32, weight: .semibold, design: .monospaced))
                        .foregroundStyle(.main)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .multilineTextAlignment(.trailing)
                        .padding(.horizontal, 16)
                        .onAppear {
                            copiedOutput = output
                        }
                    Spacer()
                }
            }
            .padding(.top, 24)

            if inputBase == .binary {
                BinaryKeyboard(input: $input, equalsAction: {})
                    .frame(height: 360)
            } else if inputBase == .decimal {
                DecimalKeyboard(input: $input, equalsAction: {})
                    .frame(height: 360)
            } else if inputBase == .hexadecimal {
                HexKeyboard(input: $input, equalsAction: {})
                    .frame(height: 360)
            }
        }
    }

    @ViewBuilder
    private func converterSeperator() -> some View {
        HStack(spacing: 12) {
            Button(action: {
                triggerHapticFeedback()
                swap(&inputBase, &outputBase)
            }) {
                Image(systemName: "arrow.up.arrow.down")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.main)
                    .frame(width: 32, height: 32)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
            }
            Rectangle()
                .frame(height: 0.5)
                .foregroundStyle(Color(.opaqueSeparator))
        }
    }

    private func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}
