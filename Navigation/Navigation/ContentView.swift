//
//  ContentView.swift
//  Navigation
//
//  Created by David Li on 2024/7/21.
//

import SwiftUI

struct ContentView: View {
    @State private var title = "SwiftUI"

    var body: some View {
        NavigationStack {
            Text("Hello, world!")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
