//
//  DiceSide.swift
//  DiceRoll
//
//  Created by Maks Winters on 21.03.2024.
//

import SwiftUI

struct DiceSide: View {
    let size: CGFloat
    let number: Int
    var body: some View {
        Rectangle()
            .fill(.white)
            .frame(width: size, height: size)
            .overlay (
                Rectangle()
                    .stroke(.black, style: StrokeStyle(lineWidth: 1))
            )
            .overlay (number == 1 ? makeDot(color: .red) : nil)
            .overlay (number == 2 ? twoDots() : nil)
            .overlay (number == 3 ? threeDots() : nil)
            .overlay (number == 4 ? fourDots() : nil)
            .overlay (number == 5 ? fiveDots() : nil)
            .overlay (number == 6 ? sixDots() : nil)
    }
    
    init?(size: CGFloat, number: Int) {
        self.size = size
        guard (1...6).contains(number) else { return nil }
        self.number = number
    }
    
}

extension DiceSide {
    func makeDot(color: Color = .black) -> some View {
        Circle()
            .fill(color)
            .frame(width: color == .red ? size / 5 : size / 6)
    }
    func twoDots() -> some View {
        HStack(spacing: size / 6) {
            makeDot(color: .black)
            makeDot(color: .black)
        }
    }
    func threeDots() -> some View {
        VStack(spacing: size / 6) {
            HStack {
                Spacer()
                makeDot()
            }
            HStack {
                Spacer()
                makeDot()
                Spacer()
            }
            HStack {
                makeDot()
                Spacer()
            }
        }
        .frame(width: size * 0.8)
    }
    func fourDots() -> some View {
        HStack(spacing: size / 3) {
            VStack(spacing: size / 3) {
                makeDot()
                makeDot()
            }
            VStack(spacing: size / 3) {
                makeDot()
                makeDot()
            }
        }
    }
    func fiveDots() -> some View {
        VStack(spacing: size / 6) {
            HStack {
                makeDot()
                Spacer()
                makeDot()
            }
            HStack {
                Spacer()
                makeDot()
                Spacer()
            }
            HStack {
                makeDot()
                Spacer()
                makeDot()
            }
        }
        .frame(width: size * 0.8)
    }
    func sixDots() -> some View {
        HStack(spacing: size / 3) {
            VStack(spacing: size / 6) {
                makeDot()
                makeDot()
                makeDot()
            }
            VStack(spacing: size / 6) {
                makeDot()
                makeDot()
                makeDot()
            }
        }
    }
}

#Preview {
    DiceSide(size: 200, number: 1)
}
