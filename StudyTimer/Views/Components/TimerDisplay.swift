//
//  TimerDisplay.swift
//  StudyTimer
//

import SwiftUI

struct TimerDisplay: View {
    let time: TimeInterval

    var body: some View {
        Text(formattedTime)
            .font(.system(size: 64, weight: .light, design: .rounded))
            .monospacedDigit()
            .accessibilityLabel("Time remaining or elapsed")
            .accessibilityValue(formattedTime)
    }

    private var formattedTime: String {
        let totalSeconds = Int(time)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60

        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        }
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    TimerDisplay(time: 25 * 60)
}
