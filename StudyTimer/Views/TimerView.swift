//
//  TimerView.swift
//  StudyTimer
//

import SwiftUI

struct TimerView: View {
    @Bindable var timer: TimerModel

    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { context in
            let remainingTime = timer.time(at: context.date)
            TimerDisplay(time: remainingTime)
                .onChange(of: remainingTime) {
                    if floor(remainingTime) <= 0 && timer.isRunning {
                        timer.end()
                    }
                }
        }
        TimerControls(isRunning: timer.isRunning, isFinished: timer.isFinished, onStart: { timer.start(at: .now) }, onPause: timer.pause, onReset: timer.reset)
    }

}

#Preview {
    NavigationStack {
        TimerView(timer: TimerModel())
    }
}
