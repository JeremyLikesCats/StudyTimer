//
//  TimerView.swift
//  StudyTimer
//

import SwiftUI

struct TimerView: View {
    @Bindable var timer: TimerModel
    @Bindable var subjects: SubjectsModel
    
    
    @State private var showingSubjectList: Bool = false
    
    var body: some View {
        ZStack {
            
            VStack {
                TimelineView(.periodic(from: .now, by: 1)) { context in
                    let remainingTime = timer.time(at: context.date)
                    TimerDisplay(time: remainingTime)
                        .onChange(of: remainingTime) {
                            if floor(remainingTime) <= 0 && timer.isRunning {
                                timer.end()
                            }
                        }
                }
                Button {
                    withAnimation(.spring(response: 0.45, dampingFraction: 0.8)) {
                        showingSubjectList = true
                    }
                } label: {
                    Text(subjects.selectedSubject?.title ?? "None")
                }
                TimerControls(isRunning: timer.isRunning, isFinished: timer.isFinished, onStart: { timer.start(at: .now) }, onPause: timer.pause, onReset: timer.reset)
            }
            if showingSubjectList {
                ChooseSubjectView(
                    subjects: subjects,
                    showingSubjectList: $showingSubjectList
                )
            }
        }
        
        
    }

}

#Preview {
    NavigationStack {
        TimerView(timer: TimerModel(), subjects: SubjectsModel())
    }
}
