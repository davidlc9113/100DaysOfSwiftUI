//
//  ContentView.swift
//  Moonshot
//
//  Created by David Li on 2024/7/16.
//

import SwiftUI

struct ContentView: View {
    let astronauts = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        Text(String(astronauts.count))
    }
}

#Preview {
    ContentView()
}
