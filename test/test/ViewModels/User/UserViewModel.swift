//
//  UserViewModel.swift
//  test
//
//  Created by Adrian Aguilar on 29/3/25.
//

import SwiftUI

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    
    func fetchUsers() {
        isLoading = true
        error = nil
        
        APIService.shared.fetchUsers { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let users):
                    self?.users = users
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            }
        }
    }
}
