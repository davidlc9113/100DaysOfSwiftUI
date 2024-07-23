//
//  AddView.swift
//  HabitTracking
//
//  Created by David Li on 2024/7/23.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var description = ""
    
    var activities: Activities
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle("New activity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let newActivity = Activity(title: title, description: description)
                    activities.data.append(newActivity)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(activities: Activities())
}
