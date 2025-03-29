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
    
    
    func updateUser(id:String, name: String, email: String) {
        if isLoading{
            return
        }
        message = nil
        isLoading = true
        
        PersistenceManager.shared.updateUser(whitUniqueID: id,name: name, email: email){ result in
            self.isLoading = false
            switch result {
            case .success():
                self.message = String(format: NSLocalizedString("update_user_succeed", comment: ""))
                NotificationCenter.default.post(name: .reloadUsers, object: nil)
            case .failure(let error):
                print( error.localizedDescription)
                self.message = String(format: NSLocalizedString("update_user_error", comment: ""))
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
            case .failure(let error):
                self.isLoading = false
                print( error.localizedDescription)
                self.message = String(format: NSLocalizedString("delete_user_error", comment: ""))
            }
        
        }
    }
    
    func deleteLocalUSer(uniqueId: String){
        PersistenceManager.shared.deleteUser(whitUniqueID: uniqueId){ result in
            self.isLoading = false
            switch result {
            case .success():
                NotificationCenter.default.post(name: .reloadUsers, object: nil)
                self.goBack = true
            case .failure(let error):
                print( error.localizedDescription)
                self.message = String(format: NSLocalizedString("delete_user_error", comment: ""))
            }
        }
    }
    
}
