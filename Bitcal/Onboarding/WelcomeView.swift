//
//  WelcomeView.swift
//  Bitcal
//
//  Created by David Akhmdbayev on 5/21/25.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage("hasSeenWelcomeScreen") var hasSeenWelcomeScreen: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            Image("WelcomeAppIcon")
                .resizable()
                .frame(width: 90, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 19.92))
                .padding(.top, 60)
            Text("Welcome to Bitcal")
                .font(.system(size: 24, weight: .medium, design: .monospaced))
            Text("The perfect calculator for binary operations.")
                .font(.system(size: 16, weight: .medium, design: .monospaced))
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray)
            Spacer()
            Button(action: { hasSeenWelcomeScreen.toggle() }) {
                ZStack {
                    Rectangle()
                        .frame(width: 322, height: 52)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    Text("Continue")
                        .font(.system(size: 18, weight: .semibold, design: .monospaced))
                        .foregroundStyle(.black)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
        }
    }
}

#Preview {
    WelcomeView()
}
