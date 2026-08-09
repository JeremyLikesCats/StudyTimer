//
//  SubjectsModel.swift
//  StudyTimer
//
//  Created by Jeremy Zhou on 4/8/2026.
//

import Foundation
import Observation

@Observable
final class SubjectsModel {
    public var subjects: [Subject] = [
        Subject(id: UUID(), title: "Math", color: "#FF0000"),
        Subject(id: UUID(), title: "English", color: "#0000FF"),
        Subject(id: UUID(), title: "Science", color: "#00AA00"),
    ]
    public var selectedSubject: Subject?
}
