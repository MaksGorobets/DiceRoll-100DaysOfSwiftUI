//
//  ContentView.swift
//  DiceRoll
//
//  Created by Maks Winters on 21.03.2024.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var storage = JSONStore()
    
    @State private var finalizedNumber = 0
    @State private var resultText = "Shake your phone!"
    @State private var rowCount = 1
    @State private var diceCount = 1
    
    var body: some View {
        NavigationStack {
            LazyHGrid(rows: Array(repeating: GridItem(.flexible(minimum: 100)), count: rowCount), spacing: 20) {
                ForEach(0..<diceCount, id: \.self) { _ in
                    RandomDice { number in
                        finalizedNumber += number
                    }
                }
            }
            .padding()
            .onShakeGesture {
                finalizedNumber = 0
                resultText = "Shaking..."
            }
            .onChange(of: finalizedNumber) {
                if finalizedNumber > 0 {
                    resultText = String(finalizedNumber)
                    appendResult()
                }
            }
            Text("Result: \(resultText)")
                .font(.title2)
            Stepper("Add dice (\(diceCount))", value: $diceCount, in: 1...6)
                .padding()
                .onChange(of: diceCount) {
                    switch diceCount {
                    case 4...6:
                        rowCount = 2
                    default:
                        rowCount = 1
                    }
                }
                .toolbar {
                    NavigationLink("History") {
                        RollHistoryView(storage: storage)
                    }
                }
                .onAppear(perform: storage.loadEntries)
                .navigationTitle("DiceRoll")
        }
    }
    
    func appendResult() {
        let newEntry = RollLog(time: .now, diceAmount: diceCount, result: finalizedNumber)
        storage.entries.append(newEntry)
        storage.saveEntries()
    }
    
}

#Preview {
    ContentView()
}
