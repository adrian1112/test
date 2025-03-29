//
//  UserListView.swift
//  test
//
//  Created by Adrian Aguilar on 29/3/25.
//

import SwiftUI
import RealmSwift

struct Residencia2: Identifiable {
    let id = UUID()
    let nombre: String
    let direccion: String
}

struct UserListView: View {
    @EnvironmentObject var loadingVM: LoadingViewModel
    @ObservedResults(User.self) var users
    @StateObject var viewModel = UserViewModel()
    @State private var showDetailUser = false
    @State private var showCreateUser = false
    @State private var selectedUser: User = User()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack() {
                ForEach(users, id: \.id) { user in
                    UserCell(user: user)
                        .onTapGesture {
                            selectedUser = user
                            showDetailUser.toggle()
                        }
                }
                Spacer()
            }
        }
//        .onReceive(NotificationCenter.default.publisher(for: .reloadUsers)) { _ in
//            viewModel.getUserSaved()
//        }
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
        .sheet(isPresented: $showCreateUser) {
            CreateUserView()
        }
        .navigationTitle("list_user_title")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showCreateUser = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct ResidenciaListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
