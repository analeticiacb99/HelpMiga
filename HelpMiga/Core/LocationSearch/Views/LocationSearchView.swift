//
//  LocationSearchView.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 25/01/23.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var starLocationText = ""
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
           // header view
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }
                
                VStack {
                    TextField("Current location", text:
                    $starLocationText)
                    .frame(height: 32)
                    .background(Color(
                        .systemGroupedBackground))
                    .padding(.trailing)
                    
                    TextField("Where to?", text:
                                $viewModel.queryFragment)
                    .frame(height: 32)
                    .background(Color(.systemGray4))
                    .padding(.trailing)
               }
                        
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
            Divider()
                .padding(.vertical)
            
            // list view
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.results, id: \.self) {result in
                        LocationSearchResultCell(title:
                                                    result.title, subtitle:
                                                    result.subtitle)
                        .onTapGesture {
                            withAnimation(.spring()){
                                viewModel.selectLocation(result)
                                mapState = .locationSelected
                            }
                        }
                    }
                }
            }
        }
        .background(Color.theme.backgorundColor)
        .background(.white)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(mapState: .constant(.searchingForLocation))
    }
}
