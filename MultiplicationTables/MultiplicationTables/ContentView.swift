//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by David Li on 2024/7/13.
//

import SwiftUI

struct ContentView: View {
    @State private var row = 2
    @State private var option = 0
    @State private var isQuestion = true
    @State private var isEnd = false
    @State private var questions = [Int]()
    
    @State private var score = 0
    @State private var currentIndex = 0
    @State private var currentAnswer = 0
    
    let options = [5, 10, 20]
    
    var body: some View {
        print(questions)
        return NavigationStack {
            VStack {
                if isQuestion {
                    Section("Which row?") {
                        Stepper("Row \(row)", value: $row, in: 2...12)
                    }
                    
                    Section("How many questions?") {
                        Picker("Number of questions", selection: $option) {
                            ForEach(0..<options.count, id:\.self) { index in
                                Text("\(options[index])")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Spacer()
                    
                    Button("Start", action: startGame)
                } else {
                    Section("\(row) x \(questions[currentIndex]) = ?") {
                        TextField("answer", value: $currentAnswer, format: .number)
                            .keyboardType(.decimalPad)
                    }
                    
                    Spacer()
                    
                    Text("Score: \(score)")
                    if !isEnd {
                        Button("Next", action: nextQuestion)
                    }
                }
            }
            .navigationTitle("Multiplication tables")
        }
        .padding()
    }
    
    func startGame() {
        isQuestion = false
        questions = (1...options[option]).map { _ in Int.random(in: 2...12)}
    }
    
    func nextQuestion() {
        if isCorrect() {
            score += 1
        }
        if currentIndex < questions.count - 1 {
            currentIndex += 1
            currentAnswer = 0
        } else {
            isEnd = true
        }
    }
    
    func isCorrect() -> Bool {
        print(currentAnswer, row * questions[currentIndex])
        return currentAnswer == row * questions[currentIndex]
    }
    
    func resetGame() {
        isQuestion = true
        isEnd = false
        currentIndex = 0
        currentAnswer = 0
    }
}

#Preview {
    ContentView()
}
