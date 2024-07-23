//
//  ContentView.swift
//  HabitTracking
//
//  Created by David Li on 2024/7/23.
//

import SwiftUI

struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    var count = 1
    let title: String
    let description: String
    
    static func == (lhs: Activity, rhs: Activity) -> Bool {
        return lhs.id == rhs.id
    }
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
                        NavigationLink(activity.title) {
                            DetailView(id: activity.id, activities: activities)
                        }
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
    
    func findActivity(by id: UUID) -> Activity {
        let filtered = activities.data.filter({ $0.id == id })
        if filtered.isEmpty == false {
            return filtered[0]
        } else {
            return Activity(title: "", description: "")
        }
    }
}

#Preview {
    ContentView()
}
