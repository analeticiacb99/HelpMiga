//
//  RegistrationView.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 01/02/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var fullname = ""
    @State private var email = ""
    @State private var password = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color(red: 255/255, green: 190/255, blue: 106/255)
                .ignoresSafeArea()
            
            VStack (alignment: .leading, spacing: 20) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .imageScale(.medium)
                        .padding()
                }
                Text("Create new account")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .frame(width: 250)
                
                Spacer()
                
                VStack {
                    
                    VStack(spacing: 56) {
                        CustomInputField(text: $fullname,
                                         title: "Full Name",
                                         placeholder: "Enter your name")
                        CustomInputField(text: $email,
                                         title: "Email address",
                                         placeholder: "name@example.com")
                        CustomInputField(text: $password,
                                         title: "Create Password",
                                         placeholder: "Enter your password",
                                         isSecureField: true)
                        
                    }
                    .padding(.leading)
                    
                    Spacer ()
                    
                    Button {
                        viewModel.registerUser(withEmail: email, password: password, fullname: fullname)
                    } label: {
                        HStack {
                            Text("SIGN UP")
                                .foregroundColor(.black)
                            Image(systemName: "arrow.right")
                                .foregroundColor(.black)
                            
                        }
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                    
                    Spacer ()
                }
            }
            .foregroundColor(.white)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
