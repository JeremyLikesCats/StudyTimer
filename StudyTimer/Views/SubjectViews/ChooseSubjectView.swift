//
//  ChooseSubjectView.swift
//  StudyTimer
//
//  Created by Jeremy Zhou on 4/8/2026.
//

import SwiftUI

struct ChooseSubjectView: View {

    @Bindable var subjects: SubjectsModel

    @State var showingAddSubjectView: Bool = false
    @State private var addSubjectVisible: Bool = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
            GlassEffectContainer {
                ScrollView {
                    VStack(spacing: 15) {
                        if showingAddSubjectView {
                            AddSubjectView(subjects: subjects, showing: $showingAddSubjectView)
                                .frame(maxWidth: .infinity)
                                .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 40))
                                .transition(.opacity)
                        }
                        VStack(spacing: 15) {
                            ForEach(subjects.subjects) { subject in
                                SubjectCapsuleRow(
                                    subject: subject,
                                    subtitle: "25:00",
                                    isSelected: subject.id == subjects.selectedSubject?.id
                                ) {
                                    subjects.selectedSubject = subject
                                    UIApplication.shared.sendAction(
                                        #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil
                                    )
                                    dismiss()
                                }
                                .glassEffect()
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .contentMargins(.horizontal, 50, for: .scrollContent)
                // Clear the floating header and footer buttons.
                .contentMargins(.top, 80, for: .scrollContent)
                .contentMargins(.bottom, 100, for: .scrollContent)
                .scrollDismissesKeyboard(.immediately)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
            }
            .overlay(alignment: .bottom) {
                Button {
                    withAnimation(.spring(response: 0.45, dampingFraction: 0.8)) {
                        showingAddSubjectView.toggle()
                    }
                } label: {
                    Image(systemName: showingAddSubjectView ? "xmark" : "plus")
                        .font(.title2)
                        .frame(width: 50, height: 50)
                }
                .buttonStyle(.glass)
                .buttonBorderShape(.circle)
                .padding()
            }

            // Back and overflow live in the content, not the navigation bar, so
            // they move with the view during the interactive dismiss instead of
            // being bridged into a UINavigationItem that animates separately.
            .overlay(alignment: .top) {
                HStack {
                    circleButton("chevron.left", size: 32) {
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil
                        )
                        dismiss()
                    }

                    Spacer()

                    circleButton("ellipsis", size: 32) {
                        // action
                    }
                }
                .padding()
            }
            .toolbar(.hidden, for: .navigationBar)
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil, from: nil, for: nil
                )
            }
    }

    /// Matches the floating add/close button so the three controls read as a set.
    private func circleButton(_ systemName: String, size: CGFloat = 50, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.title2)
                .frame(width: size, height: size)
        }
        .buttonStyle(.glass)
        .buttonBorderShape(.circle)
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
        .sensoryFeedback(.impact(weight: .heavy), trigger: isSelected) { _, isNowSelected in
            isNowSelected
        }
    }
}

#Preview {
    ContentView()
}
