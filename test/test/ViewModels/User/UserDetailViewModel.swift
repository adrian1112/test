//
//  UserDetailViewModel.swift
//  test
//
//  Created by Adrian Aguilar on 29/3/25.
//

import Foundation
import SwiftUI

class UserDetailViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var message: String? = nil
    @Published var goBack: Bool = false
    @Published var goBackAction: Bool = false
    @Published var showAlert: Bool = false
    
    func updateUser(uniqueId: String, name: String, email: String) {
        if isLoading{
            return
        }
        message = nil
        isLoading = true
        
        PersistenceManager.shared.updateUser(whitUniqueID: uniqueId,name: name, email: email){ result in
            self.isLoading = false
            switch result {
            case .success():
                self.message = String(format: NSLocalizedString("update_user_succeed", comment: ""))
                self.showAlert = true
                self.goBack = true
            case .failure(_):
                self.message = String(format: NSLocalizedString("update_user_error", comment: ""))
                self.showAlert = true
                self.goBack = false
            }
        }
    }
    
    func deleteUser(uniqueId: String, id: Int) {
        if isLoading{
            return
        }
        message = nil
        isLoading = true
        APIService.shared.deleteUSer(id: id){result in
            switch result {
            case .success():
                self.deleteLocalUSer(uniqueId: uniqueId)
            case .failure(_):
                self.isLoading = false
                self.message = String(format: NSLocalizedString("delete_user_error", comment: ""))
                self.showAlert = true
                self.goBack = false
            }
        }
    }
    
    func deleteLocalUSer(uniqueId: String){
        PersistenceManager.shared.deleteUser(whitUniqueID: uniqueId){ result in
            self.isLoading = false
            switch result {
            case .success():
                self.goBackAction = true
            case .failure(let error):
                print( error.localizedDescription)
                self.message = String(format: NSLocalizedString("delete_user_error", comment: ""))
                self.showAlert = true
                self.goBack = false
            }
        }
    }
    
}
