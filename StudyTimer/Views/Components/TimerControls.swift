//
//  TimerControls.swift
//  StudyTimer
//

import SwiftUI

struct TimerControls: View {
    let isRunning: Bool
    let isFinished: Bool
    let onStart: () -> Void
    let onPause: () -> Void
    let onReset: () -> Void

    var body: some View {
        HStack(spacing: 24) {
            Button("Reset", action: onReset)
                .buttonStyle(.bordered)
                .disabled(isRunning)

            if isRunning {
                Button("Pause", action: onPause)
                    .buttonStyle(.borderedProminent)
            } else {
                Button(isFinished ? "Restart" : "Start", action: onStart)
                    .buttonStyle(.borderedProminent)
            }
        }
        .controlSize(.large)
    }
}

#Preview {
    TimerControls(
        isRunning: false,
        isFinished: false,
        onStart: {},
        onPause: {},
        onReset: {}
    )
}
