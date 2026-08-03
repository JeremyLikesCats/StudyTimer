//
//  ContentView.swift
//  StudyTimer
//
//  Created by Jeremy Zhou on 13/7/2026.
//

import SwiftUI

struct ContentView: View {
    /// Wall-clock anchor. Elapsed time is always derived from dates,
    /// never by incrementing a counter (avoids Timer drift).
    @State private var startDate: Date?
    /// Time from previous runs so pause/resume keeps the total.
    @State private var accumulated: Duration = .zero

    private var isRunning: Bool { startDate != nil }

    var body: some View {
        VStack(spacing: 24) {
            // Cleanest continuous tick in SwiftUI:
            // TimelineView owns the cadence — no Timer, no retain cycles,
            // and updates pause automatically when the view is off-screen.
            TimelineView(.periodic(from: .now, by: 0.1)) { context in
                Text(
                    elapsed(at: context.date),
                    format: .time(pattern: .minuteSecond(padMinuteToLength: 2, fractionalSecondsLength: 1))
                )
                .font(.system(size: 56, weight: .light, design: .rounded))
                .monospacedDigit()
                .contentTransition(.numericText())
            }

            HStack(spacing: 16) {
                Button(isRunning ? "Pause" : "Start") {
                    toggle()
                }
                .buttonStyle(.borderedProminent)

                Button("Reset", role: .destructive) {
                    reset()
                }
                .buttonStyle(.bordered)
                .disabled(!isRunning && accumulated == .zero)
            }
        }
        .padding()
    }

    private func elapsed(at now: Date) -> Duration {
        guard let startDate else { return accumulated }
        return accumulated + .seconds(now.timeIntervalSince(startDate))
    }

    private func toggle() {
        if let startDate {
            accumulated += .seconds(Date.now.timeIntervalSince(startDate))
            self.startDate = nil
        } else {
            startDate = .now
        }
    }

    private func reset() {
        startDate = nil
        accumulated = .zero
    }
}

#Preview {
    ContentView()
}
