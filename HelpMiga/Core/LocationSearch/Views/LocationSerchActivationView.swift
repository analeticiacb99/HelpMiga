//
//  LocationSerchActivationView.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 24/01/23.
//

import SwiftUI

struct LocationSerchActivationView: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.black)
                .frame(width: 8, height: 8)
                .padding(.horizontal)
            Text("Where to?")
                .foregroundColor(Color(.darkGray))
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64,
               height: 50)
       .background(
       Rectangle()
           .fill(Color.white)
           .shadow(color: .black, radius: 6))
    }
}

struct LocationSerchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSerchActivationView()
    }
}
