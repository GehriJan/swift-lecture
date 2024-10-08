//
//  TimerView.swift
//  Pomodoro
//
//  Created by Jannis Gehring on 04.05.24.
//

import SwiftUI

struct TimerView: View {
    
    @Binding var buttonColor: Color
    @Binding var timeRemaining: TimeInterval
    @Binding var currentPhaseLength: TimeInterval
    @Binding var nextPhaseLength: TimeInterval
    
    var body: some View {
        ZStack {
            Circle()
                .fill(buttonColor)
                .opacity(0.2)
            Circle()
                .stroke(lineWidth: 8)
                .fill(buttonColor)
                .shadow(radius: 20)
            Circle()
                .trim(from: 0.0, to: CGFloat(1 - (timeRemaining/currentPhaseLength)))
                .stroke(style: StrokeStyle(lineWidth: 25, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(270))
            VStack {
                Text(formattedTime(time: self.timeRemaining))
                    .font(.system(size: 80))
                    .fontWeight(.bold)
                    .monospaced()
                Text(formattedTime(time: self.nextPhaseLength))
                    .font(.system(size: 40))
                    .monospaced()
                    .foregroundStyle(.gray)
            }
        }
    }
    private func formattedTime(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 //TODO: muss hier nicht INT() um die Division drumrum?
        let second = Int(time) % 60
        return String(format: "%02d:%02d", minutes, second)
    }
}
