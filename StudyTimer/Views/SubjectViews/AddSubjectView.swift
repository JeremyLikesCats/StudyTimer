//
//  AddSubjectView.swift
//  StudyTimer
//
//  Created by Jeremy Zhou on 5/8/2026.
//

import SwiftUI

struct AddSubjectView: View {

    @Bindable var subjects: SubjectsModel
    @FocusState private var isTextFieldFocused: Bool

    // Other stuff
    @Binding var showing: Bool
    
    // Subject properties
    @State private var subjectColor: Color = .primary
    @State private var subjectName: String = ""
    
    @State private var saveHapticTick = 0 // Workaround for making the haptic only trigger when clicking save
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    TextField("Subject Title", text: $subjectName)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: true, vertical: false)
                        .focused($isTextFieldFocused)
                        .task(id: showing) {
                            guard showing else { return }
                            try? await Task.sleep(for: .milliseconds(200))
                            isTextFieldFocused = true
                        }
                    HStack(spacing: 15) {
                        ColorPicker("", selection: $subjectColor)
                            .labelsHidden()
                            .scaleEffect(40/28) // match the 40pt - typically colorpicker is 28pt
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                isTextFieldFocused = false
                            }
                        
                        
                        Spacer()
                        Button {
                            isTextFieldFocused = false
                            saveHapticTick += 1
                            let newSubject = Subject(
                                    id: UUID(),
                                    title: subjectName,
                                    color: subjectColor.toHexString() ?? ""
                                )
                            
                            
                            Task { @MainActor in
                                try? await Task.sleep(for: .milliseconds(50))
                                Task { @MainActor in
                                    withAnimation(.spring(response: 0.45, dampingFraction: 0.8))  { showing = false }
                                }
                                Task { @MainActor in
                                    withAnimation(.spring(response: 0.45, dampingFraction: 0.8))  { subjects.subjects.insert(newSubject, at: 0) }
                                }

                            }
                        } label: {
                            Image(systemName: "checkmark")
                        }
                        .buttonStyle(.plain)
                        .frame(width: 40, height: 40)
                        .glassEffect()
                        .sensoryFeedback(.success, trigger: saveHapticTick)
                    }
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                
                
            }
        }
        .padding(15)
        .contentShape(RoundedRectangle(cornerRadius: 40)) // Corner radius is subject height / 2 so 40 / 2 = 20
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ContentView()
}
