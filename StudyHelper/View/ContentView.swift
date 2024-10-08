//
//  ContentView.swift
//  Pomodoro
//
//  Created by Jannis Gehring on 01.05.24.
//

import SwiftUI
import OSLog
struct globalConstant {
    static let atomicTimeMultiplier: Double = 60.0
}
struct ContentView: View {
    
    @State private var currentPhaseLength: TimeInterval = 25*globalConstant.atomicTimeMultiplier
    @State private var nextPhaseLength: TimeInterval = 5*globalConstant.atomicTimeMultiplier
    
    @State private var timeRemaining: TimeInterval = 25*globalConstant.atomicTimeMultiplier
    @State private var timer: Timer?
    @State private var isRunning: Bool = false
    
    @State private var buttonLabel: String = "Start"
    @State private var buttonColor: Color = .green
    @State private var currentConfig = Configs.short
    @State private var selectedConfig = Configs.short
    
    let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "ContentView")
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                
                VStack {
                    HStack {
                        Spacer()
                        PickerView(selectedConfig: $selectedConfig)
                            .onChange(of: selectedConfig) {
                                if !self.isRunning {
                                    changePhaseLengths()
                                    timeRemaining = currentPhaseLength
                                }
                            }
                    }
                }
                TimerView(buttonColor: $buttonColor, timeRemaining: $timeRemaining, currentPhaseLength: $currentPhaseLength, nextPhaseLength: $nextPhaseLength)
                    .frame(maxWidth: 500)
                
                HStack {
                    Button {
                        isRunning.toggle()
                        if isRunning {
                            startTimer()
                        } else {
                            stopTimer()
                        }
                    } label: {
                        Text(buttonLabel)
                            .font(.largeTitle)
                            .padding()
                    }
                    .foregroundStyle(.white)
                    .background(buttonColor)
                    .cornerRadius(15)
                    Button {
                        skipTimer()
                    } label: {
                        Text("Skip")
                            .font(.largeTitle)
                            .padding()
                    }
                    .foregroundStyle(.white)
                    .background(.blue)
                    .cornerRadius(15)
                }
                Spacer()
            }
            .padding(.horizontal, 30)
            .navigationTitle("Study Helper")
        }
        .onOpenURL(perform: { link in
            guard link.absoluteString.contains("startSession") else { return }
            let pauseState: Bool = self.currentPhaseLength < 20*globalConstant.atomicTimeMultiplier
            let isStudying: Bool = !pauseState && isRunning
            
            if !isStudying  {
                if pauseState {
                    skipTimer()
                }
                isRunning = true
                startTimer()
            }
        })
    }
    private func configFinder(config: Configs) -> String {
        return switch config {
        case .short:
            "short"
        case .middle:
            "middle"
        case .long:
            "long"
        }
    }
    private func startTimer() {
        buttonColor = .red
        buttonLabel = "Stop"
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 1 {
                timeRemaining -= 1
            } else {
                stopTimer()
                swap(&currentPhaseLength, &nextPhaseLength)
                timeRemaining = currentPhaseLength
            }
        }
    }
    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        if currentConfig != selectedConfig {
            changePhaseLengths()
        }
        
        if timeRemaining <= 3 {
            swap(&currentPhaseLength, &nextPhaseLength)
        }
        timeRemaining = currentPhaseLength
        buttonColor = .green
        buttonLabel = "Start"
    }
    private func skipTimer() {
        
        if isRunning {
            stopTimer()
        }
        swap(&currentPhaseLength, &nextPhaseLength)
        timeRemaining = currentPhaseLength
    }
    private func changePhaseLengths() {
        let studyTime = [Configs.short: 25.0*globalConstant.atomicTimeMultiplier,
                         Configs.middle: 50.0*globalConstant.atomicTimeMultiplier,
                         Configs.long: 75.0*globalConstant.atomicTimeMultiplier]
        let pauseTime = [Configs.short: 5.0*globalConstant.atomicTimeMultiplier,
                         Configs.middle: 10.0*globalConstant.atomicTimeMultiplier,
                         Configs.long: 15.0*globalConstant.atomicTimeMultiplier]
        
        currentPhaseLength = studyTime[selectedConfig]!
        nextPhaseLength = pauseTime[selectedConfig]!
        
        currentConfig = selectedConfig
    }
}

#Preview {
    ContentView()
}
