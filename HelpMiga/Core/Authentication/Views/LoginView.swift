//
//  LoginView.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 01/02/23.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
                
                VStack {
                    
                    // image and title
                    
                    Spacer()
                    
                    VStack {
                        // image
                        Image("helpMigaImage")
                            .resizable()
                            .frame(width: 200, height: 200)
                        // title
                        Text("")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    
                    // input fields
                    
                    VStack(spacing: 32) {
                        //input field 1
                        CustomInputField(text: $email, title: "Email Address", placeholder: "name@example.com")
                        
                        //input field 2
                        CustomInputField(text: $password, title: "Password", placeholder: "Enter your Paasword", isSecureField: true)
                        Button {
                            
                        } label: {
                            Text("Forgot Password")
                                .font(.system(size: 13,weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.top)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    // social sign in view
                    
                    VStack {
                        
                        // sign up buttons
                        
                        HStack {
                            Button {
                                
                            } label: {
                                HStack {
                                    Text("Sign in with Apple")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                }
                                .frame(width: UIScreen.main.bounds.width - 64, height: 48)
                                .background(Rectangle().fill(Color.white)
                                .cornerRadius(18))
                            }
                        }
                    }
                    .padding(.vertical)
                    
                    Spacer()
                    
                    // sign in button
                    
                    Button {
                        viewModel.signIn(withEmail: email, password: password)
                    } label: {
                        HStack {
                            Text("SIGN IN")
                                .foregroundColor(.black)
                            Image(systemName: "arrow.right")
                                .foregroundColor(.black)
                            
                        }
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                    
                    // sign up button
                    
                    Spacer()
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden(true)
                    } label: { 
                        HStack {
                            Text("Dont't have an account?")
                                .font(.system(size: 14))
                            Text ("Sign UP")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(.white)
                    }
                 }
              }
           }
        }
    }

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
