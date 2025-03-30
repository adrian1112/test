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
                .foregroundColor(Color.colorText)
                .padding(.trailing, 10)
            VStack(alignment: .leading) {
                Text(user.username ?? "")
                    .font(.headline)
                    .foregroundColor(.colorText)
                Text(user.name ?? "")
                    .font(.subheadline)
                    .foregroundColor(.colorText)
                Text(user.phone ?? "")
                    .font(.subheadline)
                    .foregroundColor(.colorText)
                Text(user.email ?? "")
                    .font(.subheadline)
                    .foregroundColor(.colorText)
                Text(user.address?.city ?? "")
                    .font(.subheadline)
                    .foregroundColor(.colorText)
            }
            Spacer()
        }
        .padding(10)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
        .padding(.horizontal, 20)
    }
}
