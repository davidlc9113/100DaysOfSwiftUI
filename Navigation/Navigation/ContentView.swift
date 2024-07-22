//
//  ContentView.swift
//  Navigation
//
//  Created by David Li on 2024/7/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Text("Hello, world!")
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button("Tap Me") {
                            // button action here
                        }

                        Button("Tap Me 2") {
                            // button action here
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
