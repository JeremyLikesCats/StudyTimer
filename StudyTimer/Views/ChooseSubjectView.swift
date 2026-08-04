//
//  ChooseSubjectView.swift
//  StudyTimer
//
//  Created by Jeremy Zhou on 4/8/2026.
//

import SwiftUI

struct ChooseSubjectView: View {
    @Bindable var subjects: SubjectsModel
    @Binding var selectedSubjectID: UUID?
    var body: some View {
        
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(subjects.subjects) { subject in
                    // Add logic for row here
                    SubjectCapsuleRow(
                        subject: subject,
                        subtitle: "25:00",
                        isSelected: subject.id == selectedSubjectID
                    ) {
                        selectedSubjectID = subject.id
                    }
                }
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
    }
}


struct SubjectCapsuleRow: View {
    let subject: Subject
    var subtitle: String? = nil
    var isSelected: Bool = false
    var action: () -> Void
    private var subjectColor: Color {
        Color(hex: subject.color) ?? .gray
    }
    var body: some View {
        Button(action: action) {
            ZStack {
                HStack(spacing: 15) {
                    Circle()
                        .fill(isSelected ? Color.white.opacity(0.9) : subjectColor)
                        .frame(width: 40, height: 40)
                    Spacer()
                }
                Text(subject.title)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 15)
            .frame(maxWidth: .infinity, alignment: .center)
            .contentShape(Capsule())
            .glassEffect(.regular.interactive(), in: .capsule) // same effect always
            .overlay {
                if isSelected {
                    Capsule().fill(subjectColor.opacity(0.35)) // selection wash
                }
            }
            
        }
        .buttonStyle(.plain)
    }
}

