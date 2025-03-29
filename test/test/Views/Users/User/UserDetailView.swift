//
//  DetailUserView.swift
//  test
//
//  Created by Adrian Aguilar on 29/3/25.
//

import Foundation
import SwiftUI

struct UserDetailView: View {
    @Binding var user: User
    @EnvironmentObject var loadingVM: LoadingViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = UserDetailViewModel()
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    @State private var showCustomAlert: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(){
                Form {
                    Section(header: Text("user_detail_title")) {
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
                    }
                    if(user.address != nil){
                        Section(header: Text("address")) {
                            Text(String(format: NSLocalizedString("street", comment: ""), user.address!.street ?? ""))
                            Text(String(format: NSLocalizedString("city", comment: ""), user.address!.city ?? ""))
                            Text(String(format: NSLocalizedString("zip_code", comment: ""), user.address!.zipcode ?? ""))
                        }
                    }
                    
                    Section(header: Text("contact_info")) {
                        Text(String(format: NSLocalizedString("phone", comment: ""), user.phone ?? ""))
                        Text(String(format: NSLocalizedString("website", comment: ""), user.website ?? ""))
                    }
                    if(user.company != nil){
                        Section(header: Text("company")) {
                            Text(String(format: NSLocalizedString("company_name", comment: ""), user.company!.name ?? ""))
                            Text("\(user.company!.catchPhrase ?? "")")
                        }
                    }
                    
                    Button(action: {
                        viewModel.updateUser(id: user.uniqueId, name: name, email: email)
                    }) {
                        Text("save_changes")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                if showCustomAlert {
                    CustomAlertView(
                        title: "Eliminar usuario",
                        message: "¿Esta seguro de eliminar el usuario?",
                        primaryButtonText: "Aceptar",
                        primaryAction: {
                            viewModel.deleteUser(uniqueId: self.user.uniqueId, id: self.user.id)
                            showCustomAlert = false
                        },
                        secondaryButtonText: "Cancelar",
                        secondaryAction: {
                            showCustomAlert = false
                        }
                    )
                }
            }
            .onChange(of: viewModel.isLoading) {
                viewModel.isLoading ? loadingVM.showLoading() : loadingVM.hideLoading()
            }
            .onChange(of: viewModel.goBack) {
                dismiss()
            }
            .onChange(of: viewModel.message) {
                showAlert = viewModel.message != nil
            }
            .navigationTitle("user_detail_title")
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("close") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showCustomAlert = true
                    }) {
                        Text("delete")
                            .foregroundColor(.red)
                    }
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("done") {
                        isTextFieldFocused = false
                    }
                }
            }
            .onAppear {
                name = user.name ?? ""
                email = user.email ?? ""
            }
            .alert("", isPresented: $showAlert){
                Button("ok", role: .cancel) { dismiss() }
            } message: {
                Text(viewModel.message ?? "")
            }
            
        }
        
    }
    
}

