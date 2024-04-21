//
//  RollHistoryView.swift
//  DiceRoll
//
//  Created by Maks Winters on 21.04.2024.
//

import SwiftUI

struct RollHistoryView: View {
    
    let storage: JSONStore
    
    var body: some View {
        NavigationStack {
            if !storage.entries.isEmpty {
                ScrollView(.vertical) {
                    ForEach(Array(getListOfDates()), id: \.self) { date in
                        LazyVStack(alignment: .leading) {
                            Text(date)
                                .font(.title)
                            ForEach(storage.entries) { entry in
                                if entry.getDateAsString() == date {
                                    LogEntryView(entry: entry)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .navigationTitle("History")
                .navigationBarTitleDisplayMode(.inline)
            } else {
                ContentUnavailableView("No enties yet", systemImage: "note.text")
            }
        }
    }
    
    func getListOfDates() -> Set<String> {
        var dates = Set<String>()
        
        for enty in storage.entries {
            dates.insert(enty.getDateAsString())
        }
        
        return dates
    }
}

#Preview {
    RollHistoryView(storage: JSONStore())
}
