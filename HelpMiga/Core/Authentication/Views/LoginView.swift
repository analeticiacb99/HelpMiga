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
                Color(red: 255/255, green: 190/255, blue: 106/255)
                    .ignoresSafeArea()
                
                VStack {

                    // image and title

                    Spacer()

                    VStack {
                        // image
//                        Image(systemName: "person.circle.fill")
//                            .resizable()
//                            .frame(width: 160, height: 160)

                        // title
                        Text("Chega Aqui")
                            .font(.system(size: 48))
                            .fontWeight(.black)
                            .frame(width: 320)
                            .foregroundColor(.white)

                    }

                    Spacer()

                    // input fields

                    VStack(spacing: 32) {
                        //input field 1
                        CustomInputField(text: $email, title: "Email", placeholder: "nome@exemplo.com")

                        //input field 2
                        CustomInputField(text: $password, title: "Senha", placeholder: "Digite sua senha", isSecureField: true)
                        Button {

                        } label: {
                            Text("Esqueceu a senha")
                                .font(.system(size: 13,weight: .semibold))
                                .foregroundColor(.black)
                                .padding(.top)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)

                    // social sign in view

                    VStack {



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
                                            }
                    .padding(.vertical)

                    Spacer()

                    // sign up buttons

                        Button {

                        } label: {
                            HStack {
                                Text("Sign in with Apple")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                            .frame(width: UIScreen.main.bounds.width - 54, height: 48)
                            .background(Rectangle().fill(Color.white)
                            .cornerRadius(18))
                        }

                    // sign up button

                    Spacer()

                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Text("Não tem uma conta?")
                                .font(.system(size: 14))
                            Text ("CADASTRE-SE")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(.black)
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
