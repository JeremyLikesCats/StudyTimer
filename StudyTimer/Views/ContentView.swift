//
//  ContentView.swift
//  StudyTimer
//

import SwiftUI

struct ContentView: View {
    @AppStorage("countdownMinutes") private var countdownMinutes = TimerSettings.default.countdownMinutes
    @AppStorage("defaultMode") private var defaultModeRaw = TimerSettings.default.defaultMode.rawValue
    
    @State private var timer = TimerModel()
    
    private var settings: TimerSettings {
        TimerSettings(
            countdownMinutes: countdownMinutes,
            defaultMode: TimerMode(rawValue: defaultModeRaw) ?? .countdown
        )
    }
    
    var body: some View {
        VStack {
            TimerView(timer: timer)
                .onAppear {
                    timer.setDuration(as: (countdownMinutes * 60))
                }
        }
    }
}

#Preview {
    ContentView()
}
