//
//  SecondPageView.swift
//  OnboardingExample
//
//  Created by 김수환 on 11/13/24.
//

import SwiftUI

struct SecondPageView: View {
    
    @Binding var currnetPage: OnboardingPage
    @State var isAnimationEnded: Bool = false
    
    @State var isBlurry: Bool = true
    
    let contents: [content] = [
        .init(
            title: "Protect your privacy",
            description: "arc blocks all creepy trackers",
            image: Image(systemName: "hand.raised.fill"),
            imageBackground: .red
        ),
        .init(
            title: "Auto-archives old tabs",
            description: "No more virtual dust bunnies",
            image: Image(systemName: "archivebox.fill"),
            imageBackground: .init(hex: 0xB06FA4)
        ),
        .init(
            title: "Keep your logins",
            description: "Passwords carry over from Safari",
            image: Image(systemName: "key.fill"),
            imageBackground: .blue
        ),
        .init(
            title: "Navigate faster",
            description: "Swipe anywhere to go back",
            image: Image(systemName: "hand.point.up.left.and.text.fill"),
            imageBackground: .cyan
        )
    ]
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Meet your new\nfavorite browser")
                .multilineTextAlignment(.center)
                .font(.system(size: 32, weight: .heavy))
                .foregroundStyle(.white)
                .padding(.leading, isBlurry ? 70 : 0)
                .padding(.bottom, 24)
            
            ForEach(contents) { content in
                
                HStack {
                    Circle()
                        .fill(content.imageBackground)
                        .frame(width: 32)
                        .overlay {
                            content.image
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 20)
                        }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(content.title)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(Color(hex: 0x070586))
                        Text(content.description)
                            .font(.system(size: 16, weight: .light))
                            .foregroundStyle(Color(hex: 0x624AA1))
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color(hex: 0xF5CBEF))
                }
                .padding(.horizontal, 24)
            }
            
            Spacer()
            
            Button {
                withAnimation {
                    currnetPage = .third
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
        .blur(radius: isBlurry ? 30 : 0)
        .onAppear {
            withAnimation(.easeOut(duration: 0.7)) {
                isBlurry = false
            } completion: {
                withAnimation {
                    isAnimationEnded = true
                }
            }
        }
    }
}

extension SecondPageView {
    
    struct content: Identifiable {
        
        let id: UUID = .init()
        
        let title: String
        let description: String
        let image: Image
        let imageBackground: Color
    }
}
