//
//  ContentView.swift
//  Sign In With Apple
//
//  Created by Gabriel Ramos on 26/01/23.
//

import AuthenticationServices
import SwiftUI

//struct SignInView: View {
//    @Environment(\.colorScheme) var colorScheme
//
//    @AppStorage("email") var email: String = ""
//    @AppStorage("firstName") var firstName: String = ""
//    @AppStorage("lastName") var lastName: String = ""
//    @AppStorage("userId") var userID: String = ""
//
//    private var isSignedIn: Bool {
//        !userID.isEmpty
//    }
//
//    var body: some View {
//            VStack {
//
//                if !isSignedIn {
//                    VStack {
//                        Text("Assina aí porra!")
//                        Spacer()
//                    }
//                }
//                else {
//                    Text("Welcome back!")
//                }
//
//            }
//    }
//}
    
    struct SignInButtonView: View {
        @Environment(\.colorScheme) var colorScheme
        
        @AppStorage("email") var email: String = ""
        @AppStorage("firstName") var firstName: String = ""
        @AppStorage("lastName") var lastName: String = ""
        @AppStorage("userId") var userID: String = ""
        
        @Binding var page: Int
        
        var body: some View {
            SignInWithAppleButton(.continue)  { request in
                request.requestedScopes = [.email, .fullName]
            } onCompletion: { result in
            
                switch result {
                case .success(let auth):
                    
                    switch auth.credential {
                    case let credential as ASAuthorizationAppleIDCredential:
                        
                        let userID = credential.user
                        
                        let email = credential.email
                        let firstName = credential.fullName?.givenName
                        let lastName = credential.fullName?.familyName
                        
                        self.email = email ?? ""
                        self.userID = userID
                        self.firstName = firstName ?? ""
                        self.lastName = lastName ?? ""
                        
                        page += 1
                    
                    default:
                        break
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
            }
            .signInWithAppleButtonStyle(
                colorScheme == .dark ? .white : .black
            )
            .frame(height: 50)
            .frame(width: 356)
//            .padding()
            .cornerRadius(30)
        }
    }

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInButtonView(page: <#Binding<Int>#>)
//    }
//}
