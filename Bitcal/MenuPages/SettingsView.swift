//
//  Settings.swift
//  Bitcal
//
//  Created by David Akhmdbayev on 5/21/25.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        NavigationStack {
            VStack {
                settingsNavBar(navBarName: "Settings", isBackButton: false)
                List {
                    Section {
                        Label("Request feature or report issue", systemImage: "envelope.fill")
                            .font(.system(size: 14, weight: .medium, design: .monospaced))
                            .onTapGesture {
                                triggerHapticFeedback()
                                sendFeedback()
                            }
                        Label("Rate Bitcal on App Store", systemImage: "star.fill")
                            .font(.system(size: 14, weight: .medium, design: .monospaced))
                        Label("About Developer", systemImage: "hand.wave.fill")
                            .font(.system(size: 14, weight: .medium, design: .monospaced))
                    }
                }
            }
            .background(Color(.systemGray6))
        }
    }
    
    func sendFeedback() {
        let email = "david.akhmedbayev@icloud.com" // Replace with your email address
        let subject = "Feedback for Bitcal"
        let body = "Please share your feedback here."
        
        if let url = URL(string: "mailto:\(email)?subject=\(subject)&body=\(body)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                // Handle the case where Mail app can't be opened
                print("Mail app is not available")
            }
        }
    }
    
    func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

#Preview {
    Settings()
}

struct settingsNavBar: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    @State var navBarName: String
    @State var isBackButton: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            if isBackButton == true {
                Button(action: {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.gray)
                        .frame(width: 32, height: 32)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                }
            }
            Text("\(navBarName)")
                .font(.system(size: 18, weight: .semibold, design: .monospaced))
            
            Spacer()
            
            if isBackButton == false {
                Button(action: {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.main)
                        .frame(width: 32, height: 32)
                        .background(Color(.systemBackground))
                        .clipShape(Circle())
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .background(Color(.systemGray6))
    }
}
