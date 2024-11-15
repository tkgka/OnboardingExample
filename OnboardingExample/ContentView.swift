//
//  ContentView.swift
//  OnboardingExample
//
//  Created by 김수환 on 11/13/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var currnetPage: OnboardingPage = .first
    
    var body: some View {
        ZStack {
            currnetPage.view(currentPage: $currnetPage)
                .padding(.top, 50)
                .padding(.bottom, 24)
        }.background {
            GeometryReader { proxy in
                BackgroundGradientView(offsetY: proxy.size.height + 120)
            }
        }
    }
}


enum OnboardingPage: Int, CaseIterable {
    
    case first
    case second
    case third
    
    
    @ViewBuilder
    func view(currentPage: Binding<OnboardingPage>) -> some View {
        switch self {
        case .first:
            FirstPageView(currnetPage: currentPage)
        case .second:
            SecondPageView(currnetPage: currentPage)
        case .third:
            ThirdPageView(currnetPage: currentPage)
        }
    }
}
