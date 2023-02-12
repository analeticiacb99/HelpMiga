//
//  HelpCancelledView.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 10/02/23.
//

import SwiftUI

struct HelpCancelledView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            Text(viewModel.helpCancelledMessage)
                .font(.headline)
                .padding(.vertical)
            
            Button {
                guard let user = viewModel.currentUser, user.accountMode == .active else { return }
                guard let help = viewModel.help else { return }
                
                if help.requesterUid == user.uid {
                    if help.state == .helperCancelled {
                        viewModel.deleteHelp()
                    } else if help.state == .requesterCancelled {
                        viewModel.help = nil
                    }
                } else {
                    if help.state == .requesterCancelled {
                        viewModel.deleteHelp()
                    } else if help.state == .helperCancelled {
                        viewModel.help = nil
                    }
                    
                }
            } label: {
                Text("OK")
                    .fontWeight(.black)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
        .padding(.bottom, 24)
        .frame(maxWidth: .infinity)
        .background(Color.theme.backgorundColor)
        .cornerRadius(16)
        .shadow(color: .black, radius: 20)
    }
}

struct HelpCancelledView_Previews: PreviewProvider {
    static var previews: some View {
        HelpCancelledView()
    }
}
