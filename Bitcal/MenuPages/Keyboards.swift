import SwiftUI

struct BinaryKeyboard: View {
    @Binding var input: String
    var equalsAction: () -> Void
    var onEqualsLongPress: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                binaryButton("0")
                Divider()
                binaryButton("1")
            }
            .padding(.horizontal, 8)
            .background(Color(.systemGray6))
            .clipShape(Capsule())

            HStack(spacing: 12) {
                Button(action: {
                    triggerHapticFeedback()
                    if !input.isEmpty {
                        input.removeLast()
                    }
                }) {
                    ZStack {
                        Capsule()
                            .frame(width: 100, height: 100)
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
                        input = ""
                    }
                )

                Button(action: {
                    triggerHapticFeedback()
                    equalsAction()
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
                .simultaneousGesture(
                    LongPressGesture(minimumDuration: 0.6).onEnded { _ in
                        triggerHapticFeedback()
                        onEqualsLongPress?()
                    }
                )
            }
        }
    }

    private func binaryButton(_ bit: String) -> some View {
        Button(action: {
            triggerHapticFeedback()
            input.append(bit)
        }) {
            HStack {
                Spacer()
                Text(bit)
                    .font(.system(size: 32, weight: .semibold, design: .monospaced))
                    .foregroundStyle(.main)
                Spacer()
            }
            .background(Color(.systemGray6))
        }
    }

    func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

struct DecimalKeyboard: View {
    @Binding var input: String
    var equalsAction: () -> Void
    var onEqualsLongPress: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 12) {
            ForEach(["789", "456", "123"], id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row.map { String($0) }, id: \.self) { digit in
                        keyButton(digit)
                    }
                }
            }
            HStack(spacing: 12) {
                deleteButton()
                keyButton("0")
                equalsButton()
            }
        }
    }

    private func keyButton(_ value: String) -> some View {
        Button(action: {
            triggerHapticFeedback()
            input.append(value)
        }) {
            ZStack {
                Capsule()
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .foregroundStyle(Color(.systemGray6))
                Text(value)
                    .foregroundStyle(.main)
                    .font(.system(size: 32, weight: .semibold, design: .monospaced))
            }
        }
    }

    private func deleteButton() -> some View {
        Button(action: {
            triggerHapticFeedback()
            if !input.isEmpty {
                input.removeLast()
            }
        }) {
            ZStack {
                Capsule()
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .foregroundStyle(Color(.systemGray6))
                Image(systemName: "delete.left.fill")
                    .foregroundStyle(.accent)
                    .font(.system(size: 32, weight: .semibold, design: .monospaced))
                    .padding(.trailing, 6)
            }
        }
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.6).onEnded { _ in
                triggerHapticFeedback()
                input = ""
            }
        )
    }

    private func equalsButton() -> some View {
        Button(action: {
            triggerHapticFeedback()
            equalsAction()
        }) {
            ZStack {
                Capsule()
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .foregroundStyle(.accent)
                Text("=")
                    .foregroundStyle(.main)
                    .font(.system(size: 32, weight: .semibold, design: .monospaced))
            }
        }
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.6).onEnded { _ in
                triggerHapticFeedback()
                onEqualsLongPress?()
            }
        )
    }

    private func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

struct HexKeyboard: View {
    @Binding var input: String
    var equalsAction: () -> Void
    var onEqualsLongPress: (() -> Void)? = nil

    private let hexRows = [
        ["D", "E", "F"],
        ["A", "B", "C"],
        ["7", "8", "9"],
        ["4", "5", "6"],
        ["1", "2", "3"]
    ]

    var body: some View {
        VStack(spacing: 12) {
            ForEach(hexRows, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { value in
                        keyButton(value)
                    }
                }
            }
            HStack(spacing: 12) {
                deleteButton()
                keyButton("0")
                equalsButton()
            }
        }
    }

    private func keyButton(_ value: String) -> some View {
        Button(action: {
            triggerHapticFeedback()
            input.append(value)
        }) {
            ZStack {
                Capsule()
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .foregroundStyle(Color(.systemGray6))
                Text(value)
                    .foregroundStyle(.main)
                    .font(.system(size: 16, weight: .medium, design: .monospaced))
            }
        }
    }

    private func deleteButton() -> some View {
        Button(action: {
            triggerHapticFeedback()
            if !input.isEmpty {
                input.removeLast()
            }
        }) {
            ZStack {
                Capsule()
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .foregroundStyle(Color(.systemGray6))
                Image(systemName: "delete.left.fill")
                    .foregroundStyle(.accent)
                    .font(.system(size: 16, weight: .medium, design: .monospaced))
            }
        }
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.6).onEnded { _ in
                triggerHapticFeedback()
                input = ""
            }
        )
    }

    private func equalsButton() -> some View {
        Button(action: {
            triggerHapticFeedback()
            equalsAction()
        }) {
            ZStack {
                Capsule()
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .foregroundStyle(.accent)
                Text("=")
                    .foregroundStyle(.main)
                    .font(.system(size: 20, weight: .medium, design: .monospaced))
            }
        }
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.6).onEnded { _ in
                triggerHapticFeedback()
                onEqualsLongPress?()
            }
        )
    }

    private func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}
