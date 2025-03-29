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
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var email: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Información de usuario")) {
                    HStack(){
                        Spacer()
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(Color.gray)
                            .padding(.trailing, 10)
                        Spacer()
                    }
                    
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                }
                if(user.address != nil){
                    Section(header: Text("Address")) {
                        Text("Street: \(user.address!.street ?? "")")
                        Text("City: \(user.address!.city ?? "")")
                        Text("Zip Code: \(user.address!.zipcode ?? "")")
                    }
                }
                
                Section(header: Text("Contact Info")) {
                    Text("Phone: \(user.phone ?? "")")
                    Text("Website: \(user.website ?? "")")
                }
                if(user.company != nil){
                    Section(header: Text("Company")) {
                        Text("Company Name: \(user.company!.name ?? "")")
                        Text("Slogan: \(user.company!.catchPhrase ?? "")")
                    }
                }
                
                Button(action: {
                    saveChanges()
                }) {
                    Text("Save Changes")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Detalle de usuario")
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cerrar") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                name = user.name ?? ""
                email = user.email ?? ""
            }
        }
        
    }
    
    private func saveChanges() {
        print("func guardar: \(user.name), \(user.email)")
        dismiss()
    }
}

