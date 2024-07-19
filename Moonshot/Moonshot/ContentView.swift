//
//  ContentView.swift
//  Moonshot
//
//  Created by David Li on 2024/7/16.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingGrid = false
    
    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    GridView(missions: missions, astronauts: astronauts)
                } else {
                    ListView(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("View style", systemImage: showingGrid ? "square.grid.2x2" : "list.bullet") {
                    showingGrid.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
