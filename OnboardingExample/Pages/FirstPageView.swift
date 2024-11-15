//
//  FirstPageView.swift
//  OnboardingExample
//
//  Created by 김수환 on 11/13/24.
//

import SwiftUI

struct FirstPageView: View {
    
    @Binding var currnetPage: OnboardingPage
    
    @State var startAnimation: Bool = false
    @State var isAnimationEnded: Bool = false
    
    var imageSize: CGSize {
        startAnimation
        ? .init(width: 50, height: 50)
        : .init(width: 100, height: 100)
    }
    
    func offset(_ proxy: GeometryProxy) -> CGSize {
        startAnimation
        ? .init(width: proxy.size.width / 2 - imageSize.width / 2, height: 0)
        : .init(width:0, height: proxy.size.height - imageSize.height)
    }
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Image(systemName: "globe")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .bold()
                    .foregroundStyle(.black.gradient)
                    .frame(width: imageSize.width, height: imageSize.height)
                    .offset(offset(proxy))
            }
            
            VStack {
                Spacer()
                Text("Get what you\nwant twice\nas fast.")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 40, weight: .black))
                    .foregroundStyle(.white)
                    .offset(x: startAnimation ? 0 : -300)
                    .offset(y: startAnimation ? 0 : 80)
                    .padding(.bottom, 100)
                    .blur(radius: .init(startAnimation ? 0 : 10))
                    .scaleEffect(startAnimation ? 1 : 2)
                Button {
                    withAnimation {
                        currnetPage = .second
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(hex: 0x313AFF))
                        .frame(height: 48)
                        .padding(.horizontal, 32)
                        .overlay {
                            Text("Next")
                                .foregroundStyle(.white)
                                .font(.system(size: 20, weight: .medium))
                        }
                }
                .buttonStyle(ShrinkButtonStyle())
                .opacity(isAnimationEnded ? 1 : 0)
            }
        }
        .task {
            try? await Task.sleep(nanoseconds: 500000000) // 0.5 seconds
            withAnimation(.easeOut(duration: 1.2)) {
                startAnimation = true
            } completion: {
                withAnimation {
                    isAnimationEnded = true
                }
            }
        }
    }
}
