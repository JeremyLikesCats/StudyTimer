//
//  TimerModel.swift
//  StudyTimer
//

import Foundation
import Observation

@Observable
final class TimerModel {
    let id: UUID
    var duration: TimeInterval
    var timerMode: TimerMode = .countdown
    
    
    var isRunning: Bool { startTime != nil }
    var isFinished: Bool = false
    
    // Timer uses a system date/time system to ensure accuracy - this is the date (e.g. Mon 3 Aug 11:12:50 PM that the timer starts)
    private var startTime: Date?
    private var timeElapsedBeforePaused: TimeInterval = 0 // Counts upwards from the bottom
    
    init(duration: TimeInterval = 0) {
        self.id = UUID()
        self.duration = duration
        if duration == 0 {
            timerMode = .stopwatch
        }
    }
    
    func start(at date: Date) -> Void {
        if isFinished {
            reset()
        }
        startTime = date
        isFinished = false
    }
    
    func pause() -> Void {
        guard let startTime else { return }
        let elapsed = timeElapsedBeforePaused + Date().timeIntervalSince(startTime)
        timeElapsedBeforePaused = min(elapsed, duration)
        self.startTime = nil
    }
    
    func reset() -> Void {
        startTime = nil
        isFinished = false
        timeElapsedBeforePaused = 0
    }
    
    func end() -> Void {
        isFinished = true
        pause()
    }
    
    func setDuration(as duration: TimeInterval) -> Void {
        self.duration = duration
        reset()
    }
    
    func time(at date: Date) -> TimeInterval {
        guard let startTime else {
            return duration - timeElapsedBeforePaused
        }
        let remaining = max(0, duration - (timeElapsedBeforePaused + date.timeIntervalSince(startTime)))
        return remaining
    }
}
