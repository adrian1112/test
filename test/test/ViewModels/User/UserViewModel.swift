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
        do{
            try PersistenceManager.shared.deleteAllUsers()
        }catch{
            print("cannot delete all user: \(error)")
        }
        
        APIService.shared.fetchUsers { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let users):
                    PersistenceManager.shared.createUser(users: users){ result in
                        switch result {
                        case .success():
                            self?.getUserSaved()
                            self?.error = nil
                        case .failure(let error):
                            self?.error = error.localizedDescription
                            self?.users = []
                        }
                    }
                case .failure(let error):
                    self?.error = error.localizedDescription
                    self?.users = []
                }
            }
        }
    }
    
    func getUserSaved(){
        self.users = PersistenceManager.shared.getAllUsers()
    }
    
}
