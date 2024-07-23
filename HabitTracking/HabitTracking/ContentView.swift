//
//  ContentView.swift
//  HabitTracking
//
//  Created by David Li on 2024/7/23.
//

import SwiftUI

struct Activity: Identifiable, Codable {
    var id = UUID()
    let title: String
    let description: String
}

@Observable
class Activities {
    var data = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(data) {
                UserDefaults.standard.set(encoded, forKey: "Data")
            }
        }
    }
    
    init() {
        if let savedData = UserDefaults.standard.data(forKey: "Data") {
            if let decoded = try? JSONDecoder().decode([Activity].self, from: savedData) {
                data = decoded
                return
            }
        }
        
        data = []
    }
}

struct ContentView: View {
    @State private var activities = Activities()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.data) { activity in
                    VStack {
                        Text(activity.title)
                    }
                }
                .onDelete(perform: removeActivity)
            }
            .navigationTitle("Activities")
            .toolbar {
                NavigationLink("New activity") {
                    AddView(activities: activities)
                }
            }
        }
    }
    
    func removeActivity(at offsets: IndexSet) {
        for index in offsets {
            activities.data.remove(at: index)
        }
    }
}

#Preview {
    ContentView()
}
