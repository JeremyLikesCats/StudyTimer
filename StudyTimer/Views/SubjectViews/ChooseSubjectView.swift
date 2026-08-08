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

    @State var showingAddSubjectView: Bool = false
    @State private var addSubjectVisible = false


    var body: some View {
        NavigationStack {
            GlassEffectContainer {
                ZStack {
                    ScrollView {
                        VStack(spacing:15) {
                            if showingAddSubjectView {
                                AddSubjectView(subjects: subjects, showing: $showingAddSubjectView)
                                    .frame(maxWidth: .infinity)
                                    .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 40))
                                    .transition(.opacity)
                            }
                            LazyVStack(spacing: 15) {

                                ForEach(subjects.subjects) { subject in
                                    SubjectCapsuleRow(
                                        subject: subject,
                                        subtitle: "25:00",
                                        isSelected: subject.id == selectedSubjectID
                                    ) {
                                        selectedSubjectID = subject.id
                                    }
                                    .glassEffect()
                                }
                            }
                        }
                        
                        
                    }
                    .padding(.horizontal, 50)
                    .padding(.vertical, 12)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            if showingAddSubjectView {
                                Button {
                                    withAnimation(.spring(response: 0.45, dampingFraction: 0.8)) {
                                        showingAddSubjectView.toggle()
                                    }
                                } label: {
                                    Image(systemName: "xmark")
                                }
                            } else {
                                Button {
                                    withAnimation(.spring(response: 0.45, dampingFraction: 0.8)) {
                                        showingAddSubjectView.toggle()
                                    }
                                } label: {
                                    Image(systemName: "plus")
                                }
                            }

                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                // action
                            } label: {
                                Image(systemName: "ellipsis")
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.ignoresSafeArea())

        }
        .onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil, from: nil, for: nil
            )
        }

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
            .overlay {
                if isSelected {
                    Capsule().fill(subjectColor.opacity(0.35)) // selection wash
                }
            }

        }
        .buttonStyle(.plain)
        .sensoryFeedback(.selection, trigger: isSelected) { _, isNowSelected in
            isNowSelected
        }
    }
}

#Preview {
    ContentView()
}
