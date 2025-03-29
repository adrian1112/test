//
//  UserCell.swift
//  test
//
//  Created by Adrian Aguilar on 29/3/25.
//

import Foundation
import SwiftUI

struct UserCell: View {
    var user: User
    
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(Color.gray)
                .padding(.trailing, 10)
            VStack(alignment: .leading) {
                Text(user.username ?? "")
                    .font(.headline)
                    .foregroundColor(.gray)
                Text(user.name ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(user.phone ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(user.email ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(user.address?.city ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(10)
        .background(Color.gray.opacity(0.4))
        .cornerRadius(15)
        .padding(.horizontal, 20)
    }
}
