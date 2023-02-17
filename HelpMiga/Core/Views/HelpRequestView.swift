//
//  HelpRequestView.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 28/01/23.
//

import SwiftUI

struct HelpRequestView: View {
    
    @State private var selectedDistanceCalculatedType: DistanceCalculatedType = .meters
    @EnvironmentObject var locationViewModel: HomeViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack{
            // Request help button
            
            Spacer()
            
            Button {
                homeViewModel.requestHelp()
            } label: {
                Text("PRECISO DE AJUDA")
                    .fontWeight(.black)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 200)
                    .background(Color(red: 255/255, green: 190/255, blue: 106/255))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }

        }
        .padding(.bottom, 24)
    }
}

struct HelpRequestView_Previews: PreviewProvider {
    static var previews: some View {
        HelpRequestView()
    }
}
