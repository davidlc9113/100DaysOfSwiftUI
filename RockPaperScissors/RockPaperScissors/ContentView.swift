//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by David Li on 2024/7/5.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["✊", "🖐️", "✌️"]
    @State private var moveIndex = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    @State private var isWin = false
    @State private var isResult = false
    @State private var score = 0
    @State private var index = 0
    @State private var maxIndex = 3
    
    var answer: Int {
        if shouldWin {
            return moveIndex == 2 ? 0 : moveIndex+1
        } else {
            return moveIndex == 0 ? 2 : moveIndex-1
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("\(shouldWin ? "Win" : "Lose") \(moves[moveIndex])")
                .font(.system(size: 80).bold())
            
            VStack {
                ForEach(0..<3) { number in
                    Button {
                        tapMove(number)
                    } label: {
                        Text(moves[number])
                            .font(.system(size: 160))
                    }
                }
            }
            
            Spacer()
            Spacer()
            
            Text("Score: \(score)")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
            
            Spacer()
        }
        .alert(isWin ? "Win" : "Lose", isPresented: $isResult) {
            if index >= maxIndex {
                Button("Reset", action: resetGame)
            } else {
                Button("Continue", action: askQuestion)
            }
        } message: {
            if isWin {
                Text("\(index)/\(maxIndex) Well done!")
            } else {
                Text("\(index)/\(maxIndex) It should be \(moves[answer])")
            }
        }
    }
    
    func tapMove(_ number: Int) {
        isResult = true
        index += 1
        if number == answer {
            isWin = true
            score += 1
        } else {
            isWin = false
        }
    }
    
    func askQuestion() {
        moveIndex = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    func resetGame() {
        index = 0
        score = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
