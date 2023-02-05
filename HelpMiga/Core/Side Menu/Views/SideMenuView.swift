//
//  SideMenuView.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 03/02/23.
//

import SwiftUI

struct SideMenuView: View {
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        
            VStack(spacing: 40) {
                // header view
                VStack(alignment: .leading, spacing: 32) {
                // user info
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
                }
                
                // became a miga
                    VStack (alignment: .leading, spacing: 16){
                        Text("Do more with your account")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        HStack {
                            Image(systemName: "person.2")
                                .font(.title2)
                                .imageScale(.medium)
                            Text("Become a helper")
                                .font(.system(size: 16, weight: .semibold))
                                .padding(6)
                        }
                    }
                    
                    Rectangle()
                        .frame(width: 296, height: 0.75)
                        .opacity(0.7)
                        .foregroundColor(Color(.separator))
                        .shadow(color: .black.opacity(0.7),radius: 4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                
                // option list
                VStack {
                    ForEach(SideMenuOptionViewModel.allCases) { viewModel in
                        NavigationLink(value: viewModel) {
                            SideMenuOptionView(viewModel: viewModel)
                                .padding()
                        }
                    }
                }
                .navigationDestination(for: SideMenuOptionViewModel.self) {
                    viewModel in
                    switch viewModel {
                    case .helpRequests:
                    Text("Help Requests")
                    case .settings:
                        SettingsView(user: user)
                    case .messages:
                    Text("Messages")
                    }
                }
                Spacer()
            }
            .padding(.top, 32)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SideMenuView(user: User(fullname: "John Doe", email: "johndoe@gmail.com", uid: "123456"))
        }
    }
}
