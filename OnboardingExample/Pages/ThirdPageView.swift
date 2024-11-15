//
//  ThirdPageView.swift
//  OnboardingExample
//
//  Created by 김수환 on 11/13/24.
//

import SwiftUI

struct ThirdPageView: View {
    
    @Binding var currnetPage: OnboardingPage
    @State var isAnimationEnded: Bool = false
    @State var selectedContent: String?
    
    @State var isBlurry: Bool = true
    @State var renderingViewOffset: CGFloat = 0
    
    let contents: [String] = [
        "romantic shakespearean reply",
        "things to do in paris",
        "vegetarian dinner ideas",
        "risotto vs paella",
        "whe are the beatles"
    ]
    
    var body: some View {
        VStack {
            VStack {
                if selectedContent == nil {
                    Text("Let Arc search and\nsummarize for you")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 32, weight: .heavy))
                        .foregroundStyle(.white)
                } else {
                    Circle()
                        .fill(.white)
                        .frame(height: 50)
                        .overlay {
                            Image(systemName: "checkmark")
                                .blendMode(.exclusion)
                        }
                }
            }
            .frame(height: 80)
            
            ZStack(alignment: .bottom) {
                ZStack {
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .fill(.white)
                        .padding(.horizontal, 40)
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .fill(.black)
                        .overlay {
                            if let selectedContent {
                                renderingView(selectedContent: selectedContent)
                            } else {
                                selectView()
                            }
                        }
                        .padding(.top, 8)
                        .padding(.horizontal, 48)
                }
                .offset(y: 112)
                .ignoresSafeArea()
                
                if selectedContent != nil {
                    LinearGradient(colors: [Color.clear, Color(hex: 0x2F00C1)], startPoint: .top, endPoint: .bottom)
                        .frame(height: 300)
                        .offset(y: 100)
                        .ignoresSafeArea()
                    
                    Button {
                        withAnimation {
                            currnetPage = .first
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
                }
            }
        }
        .blur(radius: isBlurry ? 30 : 0)
        .onAppear {
            withAnimation(.easeOut(duration: 0.7)) {
                isBlurry = false
            }
        }
    }
    
    @ViewBuilder
    private func renderingView(selectedContent: String) -> some View {
        GeometryReader { proxy in
            HStack {
                VStack(alignment: .leading) {
                    if isAnimationEnded {
                        HStack {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(.black)
                                .frame(width: 180, height: 180)
                            
                            VStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(.black)
                                    .frame(width: 85, height: 85)
                                
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(.black)
                                    .frame(width: 85, height: 85)
                            }
                        }
                        Rectangle()
                            .fill(.black)
                            .frame(height: 20)
                            .padding(.trailing, 80)
                    }
                    Text(selectedContent)
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundStyle(.blue)
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 30)
            .padding(.leading, 16)
            .background(Color(hex: 0xC7BBE3))
            .clipped()
            .cornerRadius(32)
            .overlay {
                VStack(spacing: 0) {
                    LinearGradient(colors: [Color.clear, Color(hex: 0x2F00C1)], startPoint: .top, endPoint: .bottom)
                        .frame(height: 30)
                    BackgroundGradientView(offsetY: 0)
                }
                .offset(y: renderingViewOffset)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.2)) {
                    renderingViewOffset = proxy.size.height * 0.3
                } completion: {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        renderingViewOffset = proxy.size.height  * 0.6
                    } completion: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            renderingViewOffset = proxy.size.height
                        } completion: {
                            isAnimationEnded = true
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func selectView() -> some View {
        VStack {
            Text("Try it!")
                .font(.system(size: 16, weight: .heavy))
                .foregroundStyle(.white)
                .padding(.vertical, 45)
            
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(hex: 0xDEE7F1))
                .overlay {
                    VStack(spacing: 0) {
                        Capsule()
                            .fill(Color(hex: 0xD4DBE3))
                            .overlay {
                                HStack {
                                    Text("Search...")
                                        .foregroundStyle(.gray)
                                        .padding(.leading, 16)
                                    Spacer()
                                }
                            }
                            .frame(height: 32)
                            .padding([.top, .horizontal], 16)
                            .padding(.bottom, 4)
                        ScrollView {
                            VStack(spacing: 4) {
                                ForEach(contents, id: \.self) { content in
                                    HStack(alignment: .top) {
                                        Image(systemName: "magnifyingglass")
                                            .renderingMode(.template)
                                            .foregroundStyle(.gray)
                                        Text(content)
                                            .foregroundStyle(.black)
                                            .font(.system(size: 14, weight: .light))
                                        Spacer()
                                        Button {
                                            withAnimation {
                                                selectedContent = content
                                            }
                                        } label: {
                                            Text("Browse for me")
                                                .font(.system(size: 10, weight: .semibold))
                                                .foregroundStyle(.black)
                                                .padding(.vertical, 8)
                                                .padding(.horizontal, 4)
                                                .background {
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .fill(Color(hex: 0xD2D1D8))
                                                        .strokeBorder(Color.gray, lineWidth: 1)
                                                }
                                        }
                                    }
                                    .padding(.horizontal, 8)
                                }
                            }
                        }
                        Image("keyboard")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
        }
    }
}


// MARK: - Preview

#Preview {
    ThirdPageView(currnetPage: .constant(.third))
        .background(.gray)
}
