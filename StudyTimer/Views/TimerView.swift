//
//  TimerView.swift
//  StudyTimer
//

import SwiftUI

struct TimerView: View {
    @Bindable var timer: TimerModel
    @Bindable var subjects: SubjectsModel
    
    @Namespace private var namespace
    
    
    var body: some View {
        NavigationStack {
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
                    NavigationLink {
                        ChooseSubjectView(
                            subjects: subjects
                        )
                        .navigationTransition(.zoom(sourceID: "zoom", in: namespace))
                    } label: {
                        Text(subjects.selectedSubject?.title ?? "None")
                            .contentShape(Circle())
                            .matchedTransitionSource(id: "zoom", in: namespace)
                            
                    }
                    TimerControls(isRunning: timer.isRunning, isFinished: timer.isFinished, onStart: { timer.start(at: .now) }, onPause: timer.pause, onReset: timer.reset)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
    }

}

#Preview {
    NavigationStack {
        TimerView(timer: TimerModel(), subjects: SubjectsModel())
    }
}
