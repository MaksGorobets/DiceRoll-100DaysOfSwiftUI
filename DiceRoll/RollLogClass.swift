//
//  RollLogClass.swift
//  DiceRoll
//
//  Created by Maks Winters on 21.04.2024.
//

import Foundation

class RollLog: Codable, Identifiable {
    static let formatter = DateFormatter()
    
    let time: Date
    let diceAmount: Int
    let result: Int
    
    init(time: Date, diceAmount: Int, result: Int) {
        self.time = time
        self.diceAmount = diceAmount
        self.result = result
    }
    
    func getTimeAsString() -> String{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        return formatter.string(from: self.time)
    }
    
    func getDateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: self.time)
    }
}
