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
            DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
                .labelsHidden()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
