//
//  HabitView.swift
//  StudyTimer
//
//  Created by Xavier Lin on 4/8/2026.
//

import SwiftUI




struct NewHabitV: View {
    
    @State private var name: String = ""
    @State private var description: String = ""
    
    // Declare the dictionary property type
    @State private var habit: [String: Any] = [:]
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Enter New Habit: ", text: $name)
                .textFieldStyle(.roundedBorder)
            
            // Changed SecureField to TextField so text is visible
            TextField("Enter description: ", text: $description)
                .textFieldStyle(.roundedBorder)
            
            
            // 2. Assign values to the dictionary inside an action (like a Button)
            Button("Save Habit") {
                habit["Habit"] = name
                habit["description"] = description
                habit["date"] = Date()
                print("Saved habits: \(habit)")
                
        
            }
            HabitsView(outputValue: $habit)
        }
    
    }
}
struct HabitsView : View {
    @Binding var outputValue: [String: Any]
    var body: some View{
        
    }
}

#Preview {NewHabitV()}
    

