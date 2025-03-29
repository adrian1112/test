//
//  CreateUser.swift
//  test
//
//  Created by Adrian Aguilar on 29/3/25.
//

import Foundation
import SwiftUI

struct CreateUserView: View {
    @EnvironmentObject var loadingVM: LoadingViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = CreateUserViewModel()
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var showAlert: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("information")) {
                    HStack(){
                        Spacer()
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(Color.gray)
                            .padding(.trailing, 10)
                        Spacer()
                    }
                    
                    TextField("name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($isTextFieldFocused)
                    TextField("email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .focused($isTextFieldFocused)
                    TextField(String(format: NSLocalizedString("phone", comment: ""), ""), text: $phone)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($isTextFieldFocused)
                        .keyboardType(.phonePad)
                    if viewModel.errorString != "" {
                        Text(viewModel.errorString)
                            .foregroundColor(.red)
                            .frame(height: 45)
                    }
                }
        
                Button(action: {
                    viewModel.createUser(name: name, email: email, phone: phone)
                }) {
                    Text("save_changes")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .onChange(of: viewModel.isLoading) {
                viewModel.isLoading ? loadingVM.showLoading() : loadingVM.hideLoading()
            }
            .onChange(of: viewModel.message) {
                showAlert = viewModel.message != nil
            }
            .navigationTitle("create_user_title")
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("close") {
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("done") {
                        isTextFieldFocused = false
                    }
                }
            }
            .alert("", isPresented: $showAlert){
                Button("ok", role: .cancel) { dismiss() }
            } message: {
                Text(viewModel.message ?? "")
            }
        }
        
    }
    
}

