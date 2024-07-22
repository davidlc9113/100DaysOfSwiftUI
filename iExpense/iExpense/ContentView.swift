//
//  ContentView.swift
//  iExpense
//
//  Created by David Li on 2024/7/14.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decoded = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decoded
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var path = NavigationPath()
    
    var personalExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }
    
    var businessExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(personalExpenses) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(amountStyle(for: item.amount))
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                }
                
                Section("Business") {
                    ForEach(businessExpenses) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(amountStyle(for: item.amount))
                        }
                    }
                    .onDelete(perform: removeBusinessItems)
                }
                
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink("Add Expense") {
                    AddView(expenses: expenses)
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet, for type: String) {
        let itemsForType = expenses.items.enumerated().filter { $0.element.type == type }
        let indicesToRemove = offsets.map { itemsForType[$0].offset }
        for index in indicesToRemove.sorted(by: >) {
            expenses.items.remove(at: index)
        }
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, for: "Personal")
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, for: "Business")
    }
    
    func amountStyle(for amount: Double) -> Color {
        if amount < 10 {
            return Color.green
        } else if amount < 100 {
            return Color.yellow
        } else {
            return Color.red
        }
    }
}

#Preview {
    ContentView()
}
