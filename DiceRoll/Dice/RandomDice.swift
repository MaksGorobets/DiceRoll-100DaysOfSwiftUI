//
//  RandomDice.swift
//  DiceRoll
//
//  Created by Maks Winters on 26.03.2024.
//

import SwiftUI
import Combine

struct RandomDice: View {
    
    @State private(set) var number = 1
    @State private var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    let publisherPlaceholder = Timer.publish(every: 10000, on: .main, in: .tracking).autoconnect()
    @State private var isAnimating = false
    
    @State var returnResult: (Int) -> Void
    
    var body: some View {
        DiceSide(size: 100, number: number)
            .onShakeGesture {
                start()
            }
            .onReceive(timer ?? publisherPlaceholder) { time in
                if isAnimating {
                    randomize()
                }
            }
    }
    func start() {
        isAnimating = true
        timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            timer?.upstream.connect().cancel()
            isAnimating = false
            returnResult(number)
        }
    }
    
    func randomize() {
        withAnimation() {
            number = Int.random(in: 1...6)
        }
    }
}

#Preview {
    RandomDice(returnResult: { _ in })
}
