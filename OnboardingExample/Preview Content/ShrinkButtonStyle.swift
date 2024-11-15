//
//  ShrinkButtonStyle.swift
//  OnboardingExample
//
//  Created by 김수환 on 11/13/24.
//

import SwiftUI

struct ShrinkButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
