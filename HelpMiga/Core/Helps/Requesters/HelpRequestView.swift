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
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            // Help info view
            
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 32)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 8, height: 8)
                }
                
                VStack (alignment: .leading, spacing: 24) {
                        HStack {
                            Text ("Current location")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Text(locationViewModel.departureTime ?? "")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.gray)
                        }
                        .padding(.bottom, 10)
                        
                        HStack {
                            if let location = locationViewModel.selectedDestinationLocation {
                                Text (location.title)
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            
                            Spacer()
                            
                            Text(locationViewModel.arrivalTime ?? "")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.gray)
                    }
                }
                .padding(.leading, 6)
            }
            .padding()
            
            Divider()
            
            // DistanceCalculated
            HStack (spacing: 12) {
            ForEach (DistanceCalculatedType.allCases) { type in
                   Text ("\(type.description):")
                        .font(.system(size: 14, weight:.semibold))
                 
                Text("\(locationViewModel.computeDestinationDistance(forType:type).toDecimal()) m")
                      
                }
            }
            .padding()
            
            Divider()
            
            // Request help button
            
            Button {
                homeViewModel.requestHelp()
            } label: {
                Text("CONFIRM REQUEST")
                    .fontWeight(.black)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 200)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }

        }
        .padding(.bottom, 24)
        .background(Color.theme.backgorundColor)
        .cornerRadius(16)
    }
}

struct HelpRequestView_Previews: PreviewProvider {
    static var previews: some View {
        HelpRequestView()
    }
}
