//
//  ContentView.swift
//  MockingDemo
//
//  Created by Mohammad Azam on 10/11/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var loginVM = LoginViewModel(service: NetworkServiceFactory.create())
    @State private var message: String = ""
    
    var errorMessage: String {
        switch loginVM.loginStatus {
            case .denied:
                return "Invalid credentials"
            case .validationFailed:
                return "Required fields are missing"
            default:
                return ""
        }
    }
    
    var body: some View {
        
        let _ = Self._printChanges()
        
        NavigationView {
            
            VStack {
                Form {
                    TextField("User name", text: $loginVM.username)
                        .accessibilityIdentifier("usernameTextField")
                    
                    TextField("Password", text: $loginVM.password)
                        .accessibilityIdentifier("passwordTextField")
                    
                    HStack {
                        Spacer()
                        Button {
                            loginVM.login()
                        } label: {
                            Text("Login")
                                .accessibilityIdentifier("loginButton")
                        }
                        Spacer()
                    }
                    
                    Text(errorMessage)
                        .accessibilityIdentifier("messageText")
                }
                
                NavigationLink(isActive: .constant(loginVM.loginStatus == .authenticated)) {
                    DashboardView()
                } label: {
                    EmptyView()
                }

                
            }
            .navigationTitle("Login")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
