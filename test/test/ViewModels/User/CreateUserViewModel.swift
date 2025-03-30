//
//  CreateUserViewModel.swift
//  test
//
//  Created by Adrian Aguilar on 29/3/25.
//

import Foundation
import SwiftUI

class CreateUserViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var message: String? = nil
    @Published var errorString: String = ""
    
    func createUser(name: String, email: String, phone: String) {
        if isLoading{
            return
        }
        message = nil
        errorString = ""
        if !name.isNotEmpty {
            errorString = String(format: NSLocalizedString("empty_name", comment: ""))
            return
        }
        if !email.isNotEmpty {
            errorString = String(format: NSLocalizedString("empty_email", comment: ""))
            return
        }
        if !email.isValidEmail {
            errorString = String(format: NSLocalizedString("invalid_email", comment: ""))
            return
        }
        if !phone.isValidPhone {
            errorString = String(format: NSLocalizedString("invalid_phone", comment: ""))
            return
        }
        isLoading = true
        let newUser = User()
        newUser.name = name
        newUser.email = email
        newUser.phone = phone
        PersistenceManager.shared.createUser(users: [newUser]){ result in
            self.isLoading = false
            switch result {
            case .success():
                self.message = String(format: NSLocalizedString("create_user_succeed", comment: ""))
            case .failure(let error):
                print( error.localizedDescription)
                self.message = String(format: NSLocalizedString("create_user_error", comment: ""))
            }
        }
    }
}
