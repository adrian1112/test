//
//  LoadingView.swift
//  test
//
//  Created by Adrian Aguilar on 29/3/25.
//

import SwiftUI

class LoadingViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    func showLoading() { isLoading = true }
    func hideLoading() { isLoading = false }
}

struct LoadingView: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                ZStack {
                    Circle()
                        .trim(from: 0.2, to: 1)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                        .frame(width: 80, height: 80)
                    Circle()
                        .trim(from: 0, to: 0.2)
                        .stroke(Color.white, lineWidth: 10)
                        .frame(width: 80, height: 80)
                        .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
                }
                .onAppear {
                    isAnimating = true
                }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
