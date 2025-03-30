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
                    UserInfoSection(name: $name, email: $email, isTextFieldFocused: $isTextFieldFocused)
                    if(user.address != nil){
                        AddressSection(address: user.address!)
                    }
                    Section(header: Text("contact_info")) {
                        Text(String(format: NSLocalizedString("phone", comment: ""), user.phone ?? ""))
                        Text(String(format: NSLocalizedString("website", comment: ""), user.website ?? ""))
                    }
                    if(user.company != nil){
                        CompanySection(company: user.company!)
                    }
                    
                    Button(action: {
                        viewModel.updateUser(uniqueId: user.uniqueId, name: name, email: email)
                    }) {
                        Text("save_changes")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .onChange(of: viewModel.goBackAction) { dismiss() }
                .onChange(of: viewModel.message) { showAlert = viewModel.message != nil }
                .onAppear {
                    name = user.name ?? ""
                    email = user.email ?? ""
                }
                if showCustomAlert {
                    CustomAlertView(
                        title: NSLocalizedString("delete_user_title", comment: ""),
                        message: NSLocalizedString("delete_user_description", comment: ""),
                        primaryButtonText: NSLocalizedString("ok", comment: ""),
                        primaryAction: {
                            viewModel.deleteUser(uniqueId: self.user.uniqueId, id: self.user.id)
                            showCustomAlert = false
                        },
                        secondaryButtonText: NSLocalizedString("cancel", comment: ""),
                        secondaryAction: {
                            showCustomAlert = false
                        }
                    )
                }
            }
            .navigationTitle("user_detail_title")
            .toolbar{ toolbarItems }
            .scrollContentBackground(.hidden)
            
            .onChange(of: viewModel.isLoading) {
                viewModel.isLoading ? loadingVM.showLoading() : loadingVM.hideLoading()
            }
            
            .alert("", isPresented: $viewModel.showAlert) {
                Button("ok", role: .cancel) {
                    showAlert = false
                    if viewModel.goBack { dismiss() }
                }
            } message: {
                Text(viewModel.message ?? "")
            }
        }
    }
    
    private var toolbarItems: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("close") { dismiss() }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showCustomAlert = true }) {
                    Text("delete").foregroundColor(.red)
                }
            }
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("done") { isTextFieldFocused = false }
            }
        }
    }
    
}

struct UserInfoSection: View {
    @Binding var name: String
    @Binding var email: String
    var isTextFieldFocused: FocusState<Bool>.Binding
    
    var body: some View {
        Section(header: Text("user_detail_title")) {
            HStack {
                Spacer()
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.colorText)
                    .padding(.trailing, 10)
                Spacer()
            }
            TextField("name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused(isTextFieldFocused)
            TextField("email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .focused(isTextFieldFocused)
        }
    }
}

struct AddressSection: View {
    let address: Address
    
    var body: some View {
        Section(header: Text("address")) {
            Text(String(format: NSLocalizedString("street", comment: ""), address.street ?? ""))
            Text(String(format: NSLocalizedString("city", comment: ""), address.city ?? ""))
            Text(String(format: NSLocalizedString("zip_code", comment: ""), address.zipcode ?? ""))
        }
    }
}

struct CompanySection: View {
    let company: Company
    
    var body: some View {
        Section(header: Text("company")) {
            Text(String(format: NSLocalizedString("company_name", comment: ""), company.name ?? ""))
            Text("\(company.catchPhrase ?? "")")
        }
    }
}
