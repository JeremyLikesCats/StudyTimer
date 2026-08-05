//
//  AddSubjectView.swift
//  StudyTimer
//
//  Created by Jeremy Zhou on 5/8/2026.
//

import SwiftUI

struct AddSubjectView: View {
    
    @Bindable var subjects: SubjectsModel
    
    
    // Subject properties
    @State private var subjectColor: Color = .primary
    @State private var subjectName: String = ""
    
    var body: some View {
        ZStack {
            HStack(spacing: 15) {
                ColorPicker("", selection: $subjectColor)
                    .labelsHidden()
                    .scaleEffect(40/28) // match the 40pt - typically colorpicker is 28pt
                    .frame(width: 40, height: 40)
                
                

                
                Spacer()
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 15)
        }
        
        .frame(maxWidth: .infinity)
        .contentShape(Capsule())
        .glassEffect(.regular.interactive(), in: .capsule)
        .padding(.horizontal, 50)      // ← AFTER glass: pulls capsule in from screen edges
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
