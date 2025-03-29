//
//  CustomAlertView.swift
//  test
//
//  Created by Adrian Aguilar on 29/3/25.
//

import Foundation
import SwiftUI

struct CustomAlertView: View {
    let title: String
    let message: String
    let primaryButtonText: String
    let primaryAction: () -> Void
    let secondaryButtonText: String
    let secondaryAction: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {}
            VStack(spacing: 20) {
                Text(title)
                    .font(.headline)
                Text(message)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                HStack(spacing: 12) {
                    Button(action: secondaryAction) {
                        Text(secondaryButtonText)
                            .font(.body)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(.gray)
                            .cornerRadius(8)
                    }

                    Button(action: primaryAction) {
                        Text(primaryButtonText)
                            .font(.body)
                            .foregroundColor(.red)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
            .background(Color.gray)
            .cornerRadius(12)
            .shadow(radius: 10)
            .padding(.horizontal, 40)
        }
    }
}
