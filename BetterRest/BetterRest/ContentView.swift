//
//  ContentView.swift
//  BetterRest
//
//  Created by David Li on 2024/7/6.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    
    var body: some View {
        VStack {
            Text(Date.now.formatted(date: .long, time: .shortened))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
