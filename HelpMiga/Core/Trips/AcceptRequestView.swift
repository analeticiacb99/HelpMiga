//
//   AcceptTripView.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 07/02/23.
//

import SwiftUI
import MapKit

struct _AcceptRequestView: View {
    @State private var region: MKCoordinateRegion
    
    init() {
        let center = CLLocationCoordinate2D(latitude: -22.9777, longitude: 43.2320)
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        self.region = MKCoordinateRegion(center: center, span: span)
    }
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            // Would you like to accept view
            VStack {
                HStack {
                    Text("Would you like to accept this request?")
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
            
            // User info view
            VStack {
                
                HStack {
                    Image("female-profile-photo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("ANA LETICIA")
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
            // Gathering location
            VStack {
                HStack {
                    // addres info
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Apple Campus")
                            .font(.headline)
                        
                        Text("Infinite Loop 1, Santa Clara County")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    // distance
                    VStack {
                        Text("200")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text("m")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                // map
                Map(coordinateRegion: $region)
                    .frame(height: 220)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.6), radius: 10)
                    .padding()
                
                Divider()
            }
            
            // Action buttons
            HStack {
                Button {
                    
                } label: {
                    Text("Reject")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 32, height: 56)
                        .background(Color(.systemRed))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }

                Spacer()
                
                Button {
                    
                } label: {
                    Text("Accept")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 32, height: 56)
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
            }
            .padding(.top)
            .padding(.horizontal)
        }
    }
}

struct _AcceptRequestView_Previews: PreviewProvider {
    static var previews: some View {
        _AcceptRequestView()
    }
}
