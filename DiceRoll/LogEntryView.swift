//
//  LogEntryView.swift
//  DiceRoll
//
//  Created by Maks Winters on 21.04.2024.
//

import SwiftUI

struct LogEntryView: View {
    
    let entry: RollLog
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "dice.fill")
                    .font(.system(size: 45))
                Text(String(entry.diceAmount))
            }
            Text("Result: \(entry.result)")
                .font(.system(size: 30))
            Spacer()
            Text(entry.getTimeAsString())
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(5)
        .overlay {
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(style: StrokeStyle())
        }
    }
}

#Preview {
    LogEntryView(entry: RollLog(time: .now, diceAmount: 5, result: 14))
}
