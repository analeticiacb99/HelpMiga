//
//  HelpAcceptedView.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 09/02/23.
//

import SwiftUI

struct HelpAcceptedView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            if let help = viewModel.help {
                
                VStack {
                    HStack{
                        
                        Text("Encontre sua ajudante em \(help.mettingLocationName)")
                        .font(.body)
                        .frame(height: 44)
                        .lineLimit(2)
                        .padding(.trailing)
                    
                    Spacer()
                    
                    VStack {
                        Text("\(help.walkingTimeToRequester)")
                            .bold()
                        Text("min")
                            .bold()
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
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(help.helperName)
                                .fontWeight(.bold)
                            
//                            HStack {
//                                Image(systemName: "star.fill")
//                                    .foregroundColor(Color(.systemYellow))
//                                    .imageScale(.small)
//                                
//                                Text("4.8")
//                                    .font(.footnote)
//                                    .foregroundColor(.gray)
//                            }
                        }
                        
                        Spacer()
                        
                    }
                    
                    Divider()
                }
                .padding()
            }
        
            Button {
                viewModel.cancelHelpAsRequester()
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

struct HelpAcceptedView_Previews: PreviewProvider {
    static var previews: some View {
        HelpAcceptedView()
    }
}
