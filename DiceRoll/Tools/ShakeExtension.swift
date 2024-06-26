//
//  ShakeExtension.swift
//  DiceRoll
//
//  Created by Maks Winters on 26.03.2024.
//
// https://medium.com/@abdelrahman_adm/shake-gesture-in-swiftui-1ce0342fbb4e
//

import Foundation
import UIKit
import SwiftUI

extension UIDevice {
  static let deviceDidShake = Notification.Name(rawValue: "deviceDidShake")
}

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with: UIEvent?) {
        guard motion == .motionShake else { return }
    
    NotificationCenter.default.post(name: UIDevice.deviceDidShake, object: nil)
  }
}

struct ShakeGestureViewModifier: ViewModifier {
  let action: () -> Void
  
  func body(content: Content) -> some View {
    content
      .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShake)) { _ in
        action()
      }
  }
}

extension View {
  public func onShakeGesture(perform action: @escaping () -> Void) -> some View {
    self.modifier(ShakeGestureViewModifier(action: action))
  }
}
