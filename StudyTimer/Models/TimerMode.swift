//
//  TimerMode.swift
//  StudyTimer
//

import Foundation

enum TimerMode: String, CaseIterable, Identifiable {
    case countdown
    case stopwatch

    var id: String { rawValue }

    var title: String {
        switch self {
        case .countdown: "Countdown"
        case .stopwatch: "Stopwatch"
        }
    }
}
