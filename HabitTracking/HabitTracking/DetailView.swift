//
//  DetailView.swift
//  HabitTracking
//
//  Created by David Li on 2024/7/23.
//

import SwiftUI

struct DetailView: View {
    var activity: Activity
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    Text(activity.title)
                }
                
                Section("Description") {
                    Text(activity.description)
                }
            }
            .navigationTitle("Activity detail")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    DetailView(activity: Activity(title: "Title", description: "Description"))
}
