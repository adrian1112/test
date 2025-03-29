//
//  UserListView.swift
//  test
//
//  Created by Adrian Aguilar on 29/3/25.
//

import SwiftUI

struct Residencia2: Identifiable {
    let id = UUID()
    let nombre: String
    let direccion: String
}

struct UserListView: View {
    @EnvironmentObject var loadingVM: LoadingViewModel
    @StateObject var viewModel = UserViewModel()
    @State private var showDetailUser = false
    @State private var selectedUser: User = User()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 15) {
                HStack(){
                    Spacer()
                    Text("Lista de usuarios")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.top, 40)
                    Spacer()
                }
                
                ForEach(viewModel.users, id: \.id) { user in
                    UserCell(user: user)
                        .onTapGesture {
                            selectedUser = user
                            print("usuario seleccionado:", user);
                            showDetailUser.toggle()
                        }
                }
                
                Spacer()
            }
        }
        .onChange(of: viewModel.isLoading) {
            viewModel.isLoading ? loadingVM.showLoading() : loadingVM.hideLoading()
        }
        .onAppear {
            viewModel.fetchUsers()
        }
        .sheet(isPresented: $showDetailUser) {
            UserDetailView(user: $selectedUser)
                    .presentationDetents([.large])
        }
    }
}

struct ResidenciaListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
