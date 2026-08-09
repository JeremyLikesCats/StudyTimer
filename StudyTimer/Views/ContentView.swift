//
//  ContentView.swift
//  StudyTimer
//

import SwiftUI

struct ContentView: View {
    @AppStorage("countdownMinutes") private var countdownMinutes = TimerSettings.default.countdownMinutes
    @AppStorage("defaultMode") private var defaultModeRaw = TimerSettings.default.defaultMode.rawValue
    
    @State private var timer = TimerModel()
    @State private var subjects = SubjectsModel()
    
    private var settings: TimerSettings {
        TimerSettings(
            countdownMinutes: countdownMinutes,
            defaultMode: TimerMode(rawValue: defaultModeRaw) ?? .countdown
        )
    }
    
    var body: some View {
        VStack {
            TimerView(timer: timer, subjects: subjects)
                .onAppear {
                    timer.setDuration(as: (countdownMinutes * 60)) // Set Duration of timer
                }
        }
    }
}

#Preview {
    ContentView()
}
