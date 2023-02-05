//
//  SettingsView.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 04/02/23.
//

import SwiftUI

struct SettingsView: View {
    
    private let user: User
    @EnvironmentObject var viewModel: AuthViewModel
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                    // user info header
                    HStack {
                        Image("female-profile-photo")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 64, height: 64)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(user.fullname)
                                .font(.system(size: 16, weight: .semibold))
                            Text(user.email)
                                .font(.system(size: 14))
                                .accentColor(.black)
                                .opacity(0.77)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .imageScale(.small)
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        
                        }
                        .padding(8)
                    }
                    Section ("Settings") {
                        SettingsRowView(imageName: "bell.circle.fill", title: "Notifications", tintColor: Color(.systemPurple))
                        
                    }
                    Section ("Account") {
                        SettingsRowView(imageName: "person.2.circle.fill", title: "Become a helper", tintColor: Color(.systemBlue))
                        
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign out", tintColor: Color(.systemRed))
                            .onTapGesture {
                                viewModel.signOut()
                            }
                    
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView(user: User(fullname: "John Doe", email: "johndoe@gmail.com", uid: "123456"))
        } 
    }
}