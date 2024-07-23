//
//  DetailView.swift
//  HabitTracking
//
//  Created by David Li on 2024/7/23.
//

import SwiftUI

struct DetailView: View {
    var id: UUID
    var activities: Activities
    
    var activity: Activity {
        let filtered = activities.data.filter({ $0.id == id })
        if filtered.isEmpty == false {
            return filtered[0]
        } else {
            return Activity(title: "", description: "")
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    Text(activity.title)
                }
                
                Section("Description") {
                    Text(activity.description)
                }
                
                Section("Count") {
                    Text("\(activity.count)")
                }
            }
            .navigationTitle("Activity detail")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Bump", action: bumpActivity)
            }
        }
    }
    
    func bumpActivity() {
        if let index = activities.data.firstIndex(of: activity) {
            var newActivity = activities.data[index]
            newActivity.count += 1
            activities.data[index] = newActivity
        }
    }
}

#Preview {
    DetailView(id: UUID(), activities: Activities())
}
