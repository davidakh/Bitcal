//
//  Menu.swift
//  Bitcal
//
//  Created by David Akhmdbayev on 5/20/25.
//

import SwiftUI

struct MenuItem: View {
    @State var symbol: String
    @State var text: String
    
    var body: some View {
        HStack {
            Image(systemName: symbol)
                .font(.system(size: 18))
                .frame(width: 24, height: 24)
            Text(text)
                .font(.system(size: 16, weight: .medium, design: .monospaced))
        }
        .padding(.horizontal, 16)
        .frame(width: 220, height: 48, alignment: .leading)
        .background(Color(.systemGray6))
    }
}

struct CalculatorIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.59168*width, y: 0.08333*height))
        path.addCurve(to: CGPoint(x: 0.72343*width, y: 0.09696*height), control1: CGPoint(x: 0.66168*width, y: 0.08333*height), control2: CGPoint(x: 0.69669*width, y: 0.08334*height))
        path.addCurve(to: CGPoint(x: 0.77804*width, y: 0.15157*height), control1: CGPoint(x: 0.74694*width, y: 0.10895*height), control2: CGPoint(x: 0.76605*width, y: 0.12806*height))
        path.addCurve(to: CGPoint(x: 0.79167*width, y: 0.28332*height), control1: CGPoint(x: 0.79166*width, y: 0.17831*height), control2: CGPoint(x: 0.79167*width, y: 0.21332*height))
        path.addLine(to: CGPoint(x: 0.79167*width, y: 0.69584*height))
        path.addCurve(to: CGPoint(x: 0.77804*width, y: 0.8276*height), control1: CGPoint(x: 0.79167*width, y: 0.76584*height), control2: CGPoint(x: 0.79166*width, y: 0.80086*height))
        path.addCurve(to: CGPoint(x: 0.72343*width, y: 0.8822*height), control1: CGPoint(x: 0.76605*width, y: 0.8511*height), control2: CGPoint(x: 0.74694*width, y: 0.87022*height))
        path.addCurve(to: CGPoint(x: 0.59168*width, y: 0.89583*height), control1: CGPoint(x: 0.69669*width, y: 0.89582*height), control2: CGPoint(x: 0.66168*width, y: 0.89583*height))
        path.addLine(to: CGPoint(x: 0.40832*width, y: 0.89583*height))
        path.addCurve(to: CGPoint(x: 0.27657*width, y: 0.8822*height), control1: CGPoint(x: 0.33832*width, y: 0.89583*height), control2: CGPoint(x: 0.30331*width, y: 0.89582*height))
        path.addCurve(to: CGPoint(x: 0.22196*width, y: 0.8276*height), control1: CGPoint(x: 0.25306*width, y: 0.87022*height), control2: CGPoint(x: 0.23395*width, y: 0.8511*height))
        path.addCurve(to: CGPoint(x: 0.20833*width, y: 0.69584*height), control1: CGPoint(x: 0.20834*width, y: 0.80086*height), control2: CGPoint(x: 0.20833*width, y: 0.76584*height))
        path.addLine(to: CGPoint(x: 0.20833*width, y: 0.28332*height))
        path.addCurve(to: CGPoint(x: 0.22196*width, y: 0.15157*height), control1: CGPoint(x: 0.20833*width, y: 0.21332*height), control2: CGPoint(x: 0.20834*width, y: 0.17831*height))
        path.addCurve(to: CGPoint(x: 0.27657*width, y: 0.09696*height), control1: CGPoint(x: 0.23395*width, y: 0.12806*height), control2: CGPoint(x: 0.25306*width, y: 0.10895*height))
        path.addCurve(to: CGPoint(x: 0.40832*width, y: 0.08333*height), control1: CGPoint(x: 0.30331*width, y: 0.08334*height), control2: CGPoint(x: 0.33832*width, y: 0.08333*height))
        path.addLine(to: CGPoint(x: 0.59168*width, y: 0.08333*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.34375*width, y: 0.70833*height))
        path.addCurve(to: CGPoint(x: 0.29167*width, y: 0.76042*height), control1: CGPoint(x: 0.31499*width, y: 0.70833*height), control2: CGPoint(x: 0.29167*width, y: 0.73165*height))
        path.addCurve(to: CGPoint(x: 0.34375*width, y: 0.8125*height), control1: CGPoint(x: 0.29167*width, y: 0.78918*height), control2: CGPoint(x: 0.31499*width, y: 0.8125*height))
        path.addCurve(to: CGPoint(x: 0.39583*width, y: 0.76042*height), control1: CGPoint(x: 0.37251*width, y: 0.8125*height), control2: CGPoint(x: 0.39583*width, y: 0.78918*height))
        path.addCurve(to: CGPoint(x: 0.34375*width, y: 0.70833*height), control1: CGPoint(x: 0.39583*width, y: 0.73165*height), control2: CGPoint(x: 0.37251*width, y: 0.70833*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.5*width, y: 0.70833*height))
        path.addCurve(to: CGPoint(x: 0.44792*width, y: 0.76042*height), control1: CGPoint(x: 0.47123*width, y: 0.70833*height), control2: CGPoint(x: 0.44792*width, y: 0.73165*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.8125*height), control1: CGPoint(x: 0.44792*width, y: 0.78918*height), control2: CGPoint(x: 0.47123*width, y: 0.8125*height))
        path.addCurve(to: CGPoint(x: 0.55208*width, y: 0.76042*height), control1: CGPoint(x: 0.52877*width, y: 0.8125*height), control2: CGPoint(x: 0.55208*width, y: 0.78918*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.70833*height), control1: CGPoint(x: 0.55208*width, y: 0.73165*height), control2: CGPoint(x: 0.52877*width, y: 0.70833*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.65625*width, y: 0.70833*height))
        path.addCurve(to: CGPoint(x: 0.60417*width, y: 0.76042*height), control1: CGPoint(x: 0.62748*width, y: 0.70833*height), control2: CGPoint(x: 0.60417*width, y: 0.73165*height))
        path.addCurve(to: CGPoint(x: 0.65625*width, y: 0.8125*height), control1: CGPoint(x: 0.60417*width, y: 0.78918*height), control2: CGPoint(x: 0.62748*width, y: 0.8125*height))
        path.addCurve(to: CGPoint(x: 0.70833*width, y: 0.76042*height), control1: CGPoint(x: 0.68502*width, y: 0.8125*height), control2: CGPoint(x: 0.70833*width, y: 0.78918*height))
        path.addCurve(to: CGPoint(x: 0.65625*width, y: 0.70833*height), control1: CGPoint(x: 0.70833*width, y: 0.73165*height), control2: CGPoint(x: 0.68502*width, y: 0.70833*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.34375*width, y: 0.5625*height))
        path.addCurve(to: CGPoint(x: 0.29167*width, y: 0.61458*height), control1: CGPoint(x: 0.31499*width, y: 0.5625*height), control2: CGPoint(x: 0.29167*width, y: 0.58582*height))
        path.addCurve(to: CGPoint(x: 0.34375*width, y: 0.66667*height), control1: CGPoint(x: 0.29167*width, y: 0.64335*height), control2: CGPoint(x: 0.31499*width, y: 0.66667*height))
        path.addCurve(to: CGPoint(x: 0.39583*width, y: 0.61458*height), control1: CGPoint(x: 0.37251*width, y: 0.66667*height), control2: CGPoint(x: 0.39583*width, y: 0.64335*height))
        path.addCurve(to: CGPoint(x: 0.34375*width, y: 0.5625*height), control1: CGPoint(x: 0.39583*width, y: 0.58582*height), control2: CGPoint(x: 0.37251*width, y: 0.5625*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.5*width, y: 0.5625*height))
        path.addCurve(to: CGPoint(x: 0.44792*width, y: 0.61458*height), control1: CGPoint(x: 0.47123*width, y: 0.5625*height), control2: CGPoint(x: 0.44792*width, y: 0.58582*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.66667*height), control1: CGPoint(x: 0.44792*width, y: 0.64335*height), control2: CGPoint(x: 0.47123*width, y: 0.66667*height))
        path.addCurve(to: CGPoint(x: 0.55208*width, y: 0.61458*height), control1: CGPoint(x: 0.52877*width, y: 0.66667*height), control2: CGPoint(x: 0.55208*width, y: 0.64335*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.5625*height), control1: CGPoint(x: 0.55208*width, y: 0.58582*height), control2: CGPoint(x: 0.52877*width, y: 0.5625*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.65625*width, y: 0.5625*height))
        path.addCurve(to: CGPoint(x: 0.60417*width, y: 0.61458*height), control1: CGPoint(x: 0.62748*width, y: 0.5625*height), control2: CGPoint(x: 0.60417*width, y: 0.58582*height))
        path.addCurve(to: CGPoint(x: 0.65625*width, y: 0.66667*height), control1: CGPoint(x: 0.60417*width, y: 0.64335*height), control2: CGPoint(x: 0.62748*width, y: 0.66667*height))
        path.addCurve(to: CGPoint(x: 0.70833*width, y: 0.61458*height), control1: CGPoint(x: 0.68502*width, y: 0.66667*height), control2: CGPoint(x: 0.70833*width, y: 0.64335*height))
        path.addCurve(to: CGPoint(x: 0.65625*width, y: 0.5625*height), control1: CGPoint(x: 0.70833*width, y: 0.58582*height), control2: CGPoint(x: 0.68502*width, y: 0.5625*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.34375*width, y: 0.41667*height))
        path.addCurve(to: CGPoint(x: 0.29167*width, y: 0.46875*height), control1: CGPoint(x: 0.31499*width, y: 0.41667*height), control2: CGPoint(x: 0.29167*width, y: 0.43998*height))
        path.addCurve(to: CGPoint(x: 0.34375*width, y: 0.52083*height), control1: CGPoint(x: 0.29167*width, y: 0.49752*height), control2: CGPoint(x: 0.31499*width, y: 0.52083*height))
        path.addCurve(to: CGPoint(x: 0.39583*width, y: 0.46875*height), control1: CGPoint(x: 0.37251*width, y: 0.52083*height), control2: CGPoint(x: 0.39583*width, y: 0.49752*height))
        path.addCurve(to: CGPoint(x: 0.34375*width, y: 0.41667*height), control1: CGPoint(x: 0.39583*width, y: 0.43998*height), control2: CGPoint(x: 0.37251*width, y: 0.41667*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.5*width, y: 0.41667*height))
        path.addCurve(to: CGPoint(x: 0.44792*width, y: 0.46875*height), control1: CGPoint(x: 0.47123*width, y: 0.41667*height), control2: CGPoint(x: 0.44792*width, y: 0.43998*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.52083*height), control1: CGPoint(x: 0.44792*width, y: 0.49752*height), control2: CGPoint(x: 0.47123*width, y: 0.52083*height))
        path.addCurve(to: CGPoint(x: 0.55208*width, y: 0.46875*height), control1: CGPoint(x: 0.52877*width, y: 0.52083*height), control2: CGPoint(x: 0.55208*width, y: 0.49752*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.41667*height), control1: CGPoint(x: 0.55208*width, y: 0.43998*height), control2: CGPoint(x: 0.52877*width, y: 0.41667*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.65625*width, y: 0.41667*height))
        path.addCurve(to: CGPoint(x: 0.60417*width, y: 0.46875*height), control1: CGPoint(x: 0.62748*width, y: 0.41667*height), control2: CGPoint(x: 0.60417*width, y: 0.43998*height))
        path.addCurve(to: CGPoint(x: 0.65625*width, y: 0.52083*height), control1: CGPoint(x: 0.60417*width, y: 0.49752*height), control2: CGPoint(x: 0.62748*width, y: 0.52083*height))
        path.addCurve(to: CGPoint(x: 0.70833*width, y: 0.46875*height), control1: CGPoint(x: 0.68502*width, y: 0.52083*height), control2: CGPoint(x: 0.70833*width, y: 0.49752*height))
        path.addCurve(to: CGPoint(x: 0.65625*width, y: 0.41667*height), control1: CGPoint(x: 0.70833*width, y: 0.43998*height), control2: CGPoint(x: 0.68502*width, y: 0.41667*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.35832*width, y: 0.16667*height))
        path.addCurve(to: CGPoint(x: 0.31441*width, y: 0.17122*height), control1: CGPoint(x: 0.33499*width, y: 0.16667*height), control2: CGPoint(x: 0.32332*width, y: 0.16668*height))
        path.addCurve(to: CGPoint(x: 0.29622*width, y: 0.18941*height), control1: CGPoint(x: 0.30658*width, y: 0.17522*height), control2: CGPoint(x: 0.30022*width, y: 0.18158*height))
        path.addCurve(to: CGPoint(x: 0.29167*width, y: 0.23332*height), control1: CGPoint(x: 0.29168*width, y: 0.19832*height), control2: CGPoint(x: 0.29167*width, y: 0.20999*height))
        path.addLine(to: CGPoint(x: 0.29167*width, y: 0.30835*height))
        path.addCurve(to: CGPoint(x: 0.29622*width, y: 0.35225*height), control1: CGPoint(x: 0.29167*width, y: 0.33167*height), control2: CGPoint(x: 0.29168*width, y: 0.34334*height))
        path.addCurve(to: CGPoint(x: 0.31441*width, y: 0.37044*height), control1: CGPoint(x: 0.30022*width, y: 0.36009*height), control2: CGPoint(x: 0.30658*width, y: 0.36645*height))
        path.addCurve(to: CGPoint(x: 0.35832*width, y: 0.375*height), control1: CGPoint(x: 0.32332*width, y: 0.37498*height), control2: CGPoint(x: 0.33499*width, y: 0.375*height))
        path.addLine(to: CGPoint(x: 0.64168*width, y: 0.375*height))
        path.addCurve(to: CGPoint(x: 0.68559*width, y: 0.37044*height), control1: CGPoint(x: 0.66501*width, y: 0.375*height), control2: CGPoint(x: 0.67668*width, y: 0.37498*height))
        path.addCurve(to: CGPoint(x: 0.70377*width, y: 0.35225*height), control1: CGPoint(x: 0.69342*width, y: 0.36645*height), control2: CGPoint(x: 0.69978*width, y: 0.36009*height))
        path.addCurve(to: CGPoint(x: 0.70833*width, y: 0.30835*height), control1: CGPoint(x: 0.70832*width, y: 0.34334*height), control2: CGPoint(x: 0.70833*width, y: 0.33167*height))
        path.addLine(to: CGPoint(x: 0.70833*width, y: 0.23332*height))
        path.addCurve(to: CGPoint(x: 0.70377*width, y: 0.18941*height), control1: CGPoint(x: 0.70833*width, y: 0.20999*height), control2: CGPoint(x: 0.70832*width, y: 0.19832*height))
        path.addCurve(to: CGPoint(x: 0.68559*width, y: 0.17122*height), control1: CGPoint(x: 0.69978*width, y: 0.18158*height), control2: CGPoint(x: 0.69342*width, y: 0.17522*height))
        path.addCurve(to: CGPoint(x: 0.64168*width, y: 0.16667*height), control1: CGPoint(x: 0.67668*width, y: 0.16668*height), control2: CGPoint(x: 0.66501*width, y: 0.16667*height))
        path.addLine(to: CGPoint(x: 0.35832*width, y: 0.16667*height))
        path.closeSubpath()
        return path
    }
}
