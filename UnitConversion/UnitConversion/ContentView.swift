//
//  ContentView.swift
//  UnitConversion
//
//  Created by David Li on 2024/6/29.
//

import SwiftUI

struct ContentView: View {
    @State private var number: Double = 30
    @State private var unit = "Celsius"
    @State private var outputUnit = "Fahrenheit"
    @FocusState private var amountIsFocused: Bool
    
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    
    func toCelsius(number: Double, unit: String) -> Double {
        if unit == "Fahrenheit" {
            return (number-32)*5/9
        } else if unit == "Kelvin" {
            return number-273.15
        } else {
            return number
        }
    }
    
    func convert(celsius: Double, toUnit: String) -> String {
        let output = [
            "Fahrenheit": celsius*9/5+32,
            "Kelvin": celsius+273.15
        ]
        return (output[toUnit] ?? celsius).formatted()
    }
    
    var outputNumber: String {
        let inputCelsius = toCelsius(number: number, unit: unit)
        return convert(celsius: inputCelsius, toUnit: outputUnit)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    TextField("Enter a number", value: $number, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Temperature Unit", selection: $unit) {
                        ForEach(units, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Output") {
                    Text(outputNumber)
                    Picker("Temperature Unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Unit Conversion")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
