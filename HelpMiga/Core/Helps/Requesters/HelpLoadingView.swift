//
//  HelpLoadingView.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 09/02/23.
//

import SwiftUI

struct HelpLoadingView: View {
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            HStack {
                    Text("Conecting you to a helper...")
                        .padding()
                        .font(.subheadline)
                        
                Spacer()
                
                Spinner(lineWidth: 6, height: 64, width: 64)
                    .padding()
            }
            .padding(.bottom, 24)
        }
        .background(Color.theme.backgorundColor)
        .cornerRadius(12 )
        .shadow(color: .black, radius: 20)
    }
}

struct HelpLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        HelpLoadingView()
    }
}
