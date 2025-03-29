//
//  testApp.swift
//  test
//
//  Created by Adrian Aguilar on 29/3/25.
//

import SwiftUI

@main
struct testApp: App {
    @StateObject var loadingVM = LoadingViewModel()
    @State private var navigationPath = NavigationPath()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack(path: $navigationPath) {
                    UserListView()
                }
                .environmentObject(loadingVM)
                if loadingVM.isLoading {
                    LoadingView()
                        .transition(.opacity)
                        .zIndex(1)
                        
                }
            }
        }
    }
}
