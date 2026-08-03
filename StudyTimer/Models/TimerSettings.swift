//
//  TimerSettings.swift
//  StudyTimer
//

import Foundation

struct TimerSettings {
    var countdownMinutes: Double
    var defaultMode: TimerMode

    static let countdownPresets = [5, 15, 25, 45, 60]

    static let `default` = TimerSettings(
        countdownMinutes: 0.1,
        defaultMode: .countdown
    )
}
