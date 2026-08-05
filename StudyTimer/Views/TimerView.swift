//
//  TimerView.swift
//  StudyTimer
//

import SwiftUI

struct TimerView: View {
    @Bindable var timer: TimerModel
    @Bindable var subjects: SubjectsModel
    
    @State private var selectedSubjectID: UUID?
    
    var body: some View {
        ChooseSubjectView(
            subjects: subjects,
            selectedSubjectID: $selectedSubjectID
        )
        TimelineView(.periodic(from: .now, by: 1)) { context in
            let remainingTime = timer.time(at: context.date)
            TimerDisplay(time: remainingTime)
                .onChange(of: remainingTime) {
                    if floor(remainingTime) <= 0 && timer.isRunning {
                        timer.end()
                    }
                }
        }
        Picker("Subject", selection: $selectedSubjectID) {
            Text("None").tag(UUID?.none)
            ForEach(subjects.subjects) { subject in
                HStack {
                    Circle()
                        .fill(Color(hex: subject.color) ?? .gray)
                        .frame(width: 10, height: 10)
                    Text(subject.title)
                }
                .tag(Optional(subject.id))
            }
        }
        TimerControls(isRunning: timer.isRunning, isFinished: timer.isFinished, onStart: { timer.start(at: .now) }, onPause: timer.pause, onReset: timer.reset)
    }

}

#Preview {
    NavigationStack {
        TimerView(timer: TimerModel(), subjects: SubjectsModel())
    }
}
