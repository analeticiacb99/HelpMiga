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
            
            Text("HELP REQUEST")
                .foregroundColor(Color(.white))
                .fontWeight(.black)
        }
        .frame(width: UIScreen.main.bounds.width - 72,
               height: 72)
       .background(
       Rectangle()
           .fill(Color(red: 255/255, green: 190/255, blue: 106/255))
           .cornerRadius(12)
       )
    }
}

struct LocationSerchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSerchActivationView()
    }
}
