//
//  LocationView.swift
//  test
//
//  Created by Adrian Aguilar on 29/3/25.
//

import Foundation
import SwiftUI

struct LocationModalView: View {
    let latitude: Double
    let longitude: Double
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {}
            VStack(spacing: 20) {
                Text("location_title")
                    .font(.headline)
                Text("lat: \(latitude, specifier: "%.6f")")
                Text("ln: \(longitude, specifier: "%.6f")")
                
                Button("done", action: action)
            }
            .padding()
            .background(Color.gray)
            .cornerRadius(12)
            .shadow(radius: 10)
            .padding(.horizontal, 40)
        }
        
    }
}
