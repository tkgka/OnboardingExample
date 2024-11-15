//
//  BackgroundGradientView.swift
//  OnboardingExample
//
//  Created by 김수환 on 11/13/24.
//

import SwiftUI

struct BackgroundGradientView: View {
    
    @State var isAnimationEnded: Bool = false
    @State var offsetY: CGFloat
    
    var body: some View {
        ZStack {
            Color(hex: 0x2F00C1).ignoresSafeArea()
            FloatingClouds()
                .offset(y: offsetY)
                .scaleEffect(isAnimationEnded ? 1 : 1.5)
        }
        .ignoresSafeArea()
        .task {
            try? await Task.sleep(nanoseconds: 500000000) // 0.5 seconds
            withAnimation(.easeOut(duration: 1.2)) {
                isAnimationEnded = true
                offsetY = 0
            }
        }
    }
}

struct FloatingClouds: View {
    @Environment(\.colorScheme) var scheme
    let blur: CGFloat = 140
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Cloud(height: 150,
                      proxy: proxy,
                      color: .white,
                      rotationStart: 0,
                      duration: 60,
                      alignment: .bottomTrailing)
                Cloud(height: 300,
                      proxy: proxy,
                      color: .white,
                      rotationStart: 240,
                      duration: 50,
                      alignment: .topTrailing)
                Cloud(height: 500,
                      proxy: proxy,
                      color: .pink,
                      rotationStart: 120,
                      duration: 80,
                      alignment: .bottomLeading)
                Cloud(height: 300,
                      proxy: proxy,
                      color: .pink,
                      rotationStart: 180,
                      duration: 70,
                      alignment: .topLeading)
            }
            .blur(radius: blur)
        }
    }
}


class CloudProvider: ObservableObject {
    let offset: CGSize
    let frameHeightRatio: CGFloat
    
    init() {
        frameHeightRatio = CGFloat.random(in: 0.5 ..< 1.2)
        offset = CGSize(width: CGFloat.random(in: -150 ..< 150),
                        height: CGFloat.random(in: -150 ..< 150))
    }
}

struct Cloud: View {
    @StateObject var provider = CloudProvider()
    @State var move = false
    var height: CGFloat? = nil
    let proxy: GeometryProxy
    let color: Color
    let rotationStart: Double
    let duration: Double
    let alignment: Alignment
    
    var body: some View {
        Circle()
            .fill(color)
            .background(.ultraThinMaterial)
            .frame(height: height ?? proxy.size.height /  provider.frameHeightRatio)
            .offset(provider.offset)
            .rotationEffect(.init(degrees: move ? rotationStart : rotationStart + 360) )
        
            .animation(Animation.linear(duration: duration).repeatForever(autoreverses: false), value: move)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .opacity(0.8)
            .onAppear {
                move.toggle()
            }
    }
}
