//
//  MettingRequesterView.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 09/02/23.
//

import SwiftUI

struct MettingRequesterView: View {
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            // Would you like to accept view
            VStack {
                HStack {
                    Text("Meet Ana Leticia at Apple Campus")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(height: 44)
                    
                    Spacer()
                    
                    VStack {
                        Text("10")
                        
                        Text("min")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                    
                }
                .padding()
                
                Divider()
            }
            VStack {
                
                HStack {
                    Image("female-profile-photo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Ana Leticia")
                            .fontWeight(.bold)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color(.systemYellow))
                                .imageScale(.small)
                            
                            Text("4.8")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Spacer()
                    
                }
                
                Divider()
            }
            .padding()
            
        Button {
            print("DEBUG: Cancel help")
        } label: {
            Text("CANCEL HELP")
                .fontWeight(.black)
                .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                .background(.red)
                .cornerRadius(10)
                .foregroundColor(.white)
        }
    }
        .padding(.bottom, 24)
        .background(Color.theme.backgorundColor)
        .cornerRadius(16)
        .shadow(color: .black, radius: 20)
    }
}

struct MettingRequesterView_Previews: PreviewProvider {
    static var previews: some View {
        MettingRequesterView()
    }
}
