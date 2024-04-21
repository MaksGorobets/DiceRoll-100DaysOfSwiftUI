//
//  JSONStore.swift
//  DiceRoll
//
//  Created by Maks Winters on 21.04.2024.
//
// https://www.hackingwithswift.com/example-code/system/how-to-save-user-settings-using-userdefaults
//

import Foundation

@Observable
class JSONStore {
    
    var entries = [RollLog]()
    
    func saveEntries() {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        do {
            let entriesAsData = try encoder.encode(self.entries)
            defaults.set(entriesAsData, forKey: "ENTRIES")
        } catch {
            fatalError("Couldn't save the data")
        }
    }
    
    func loadEntries() {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        
        guard let dafaultsData = defaults.data(forKey: "ENTRIES") else {
            return
        }
        
        do {
            self.entries = try decoder.decode([RollLog].self, from: dafaultsData)
        } catch {
            fatalError("Could't load the data")
        }
    }
}
